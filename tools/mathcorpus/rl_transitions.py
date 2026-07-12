"""RL transition (schema/mcip/v1/rl_transition.schema.json) loading, packet-joining, and
cross-field policy checks — the MathCorpus-side half of issue #9.

This module never treats ``packets/*.json`` rows as transitions and never fabricates a
missing reward/terminal/action value: a null "core" field is only accepted when the record's
own ``missing_field_reasons`` names it, matching the honesty rule llm-driven-proof-search#231
and #238 require of the (not yet shipped) producer side. See docs/rl-transitions.md for the
current cross-repo status.
"""

from __future__ import annotations

import glob as _glob
import json
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from .mcip import RECORD_TYPE_TO_SCHEMA_FILE, build_schema_registry, record_hash
from .policy import PUBLIC_OR_HELDOUT, QUARANTINE_ELIGIBILITY, Finding

CORE_NULLABLE_FIELDS = ("reward", "terminated", "truncated", "action", "state", "next_state")
TERMINAL_OUTCOMES = {"kernel_verified", "kernel_fail", "rejected", "timeout", "cancelled", "error"}


def _err(code: str, msg: str) -> Finding:
    return Finding("error", code, msg)


def _warn(code: str, msg: str) -> Finding:
    return Finding("warn", code, msg)


@dataclass
class LoadResult:
    transitions: list[dict[str, Any]] = field(default_factory=list)
    structural_errors: list[str] = field(default_factory=list)


def iter_bundle_paths(arg: str) -> list[Path]:
    """Same file/dir/glob discovery convention as tools/import_mcip.py's helper."""
    p = Path(arg)
    if p.is_dir():
        return sorted(p.glob("*.json"))
    if p.is_file():
        return [p]
    return [Path(m) for m in sorted(_glob.glob(arg, recursive=True))]


def load_transitions_from_bundles(paths: list[Path]) -> LoadResult:
    """Read MCIP bundles and extract only their ``rl_transition`` records.

    Every bundle is validated structurally (bundle envelope schema, each record against the
    schema named by its own record_type, and record_hash recomputation) before any of its
    rl_transition records are trusted — a bundle that fails any of this is skipped wholesale
    and reported in ``structural_errors``, mirroring tools/import_mcip.py's fail-closed model.
    """
    import jsonschema as jsonschema_mod

    schemas, registry = build_schema_registry()
    bundle_schema = schemas["bundle.schema.json"]

    def _validator_for(schema: dict[str, Any]):
        cls = jsonschema_mod.validators.validator_for(schema)
        return cls(schema, registry=registry)

    bundle_v = _validator_for(bundle_schema)
    result = LoadResult()

    for bpath in paths:
        try:
            bundle = json.loads(bpath.read_text(encoding="utf-8"))
        except json.JSONDecodeError as e:
            result.structural_errors.append(f"{bpath}: invalid JSON ({e})")
            continue

        bundle_errors = [
            f"{bpath}: bundle schema at {'/'.join(str(x) for x in e.path) or '<root>'}: {e.message}"
            for e in bundle_v.iter_errors(bundle)
        ]
        if bundle_errors:
            result.structural_errors.extend(bundle_errors)
            continue

        record_errors: list[str] = []
        for i, rec in enumerate(bundle.get("records") or []):
            if not isinstance(rec, dict) or rec.get("record_type") != "rl_transition":
                continue
            rv = _validator_for(schemas[RECORD_TYPE_TO_SCHEMA_FILE["rl_transition"]])
            for e in rv.iter_errors(rec):
                loc = "/".join(str(x) for x in e.path) or "<root>"
                record_errors.append(f"{bpath}: records[{i}] at {loc}: {e.message}")
            if "record_hash" in rec and record_hash(rec) != rec["record_hash"]:
                record_errors.append(f"{bpath}: records[{i}]: record_hash does not match recompute")
            if not record_errors:
                result.transitions.append(rec)

        result.structural_errors.extend(record_errors)

    return result


def join_transition_to_packet(
    transition: dict[str, Any], packets_by_id: dict[str, dict[str, Any]]
) -> tuple[dict[str, Any] | None, str | None]:
    """Resolve a transition's packet_id and confirm its formal_statement_sha256 agrees.

    Never partially trusts a transition whose statement hash disagrees with the packet it
    claims to be about — that binding is the whole point of joining through a hash, not just
    an id (mirrors how import_mcip.py rejects a packet_identity/packet hash mismatch).
    """
    pid = transition.get("packet_id")
    packet = packets_by_id.get(pid)
    if packet is None:
        return None, f"packet_id '{pid}' not found in the packet corpus"
    packet_sha = (packet.get("hashes") or {}).get("formal_statement_sha256")
    txn_sha = transition.get("formal_statement_sha256")
    if packet_sha != txn_sha:
        return None, (
            f"formal_statement_sha256 mismatch: transition says {txn_sha}, "
            f"packet '{pid}' has {packet_sha}"
        )
    return packet, None


def is_publicly_exportable(transition: dict[str, Any], packet: dict[str, Any]) -> bool:
    """Public export requires BOTH the transition's own export_eligibility=='public' AND the
    joined packet's training.eligibility to already be public/heldout-public.

    A transition can never be more exportable than the packet it is about — a quarantined or
    private_audit_only packet's steps stay out of the public dataset even if the transition
    record itself was stamped public, since the packet-level restriction is the authoritative
    one (mirrors the packet-vs-child-record trust relationship documented in
    schema/mcip/v1/README.md: MCIP records are child evidence, never canonical).
    """
    if transition.get("export_eligibility") != "public":
        return False
    packet_eligibility = (packet.get("training") or {}).get("eligibility")
    if packet_eligibility in QUARANTINE_ELIGIBILITY:
        return False
    return packet_eligibility in PUBLIC_OR_HELDOUT


def check_transition_record(transition: dict[str, Any]) -> list[Finding]:
    """Cross-field rules the JSON Schema can't express: a null core field must be explained."""
    findings: list[Finding] = []
    rid = transition.get("record_id", "<unknown>")
    reasons = transition.get("missing_field_reasons") or {}

    for name in CORE_NULLABLE_FIELDS:
        if transition.get(name) is not None:
            continue
        if name in reasons:
            continue
        findings.append(_err(
            "rl_transition_unexplained_missing_field",
            f"{rid}: '{name}' is null with no matching missing_field_reasons entry",
        ))

    outcome = transition.get("outcome")
    if outcome == "unknown" and "outcome" not in reasons:
        findings.append(_warn(
            "rl_transition_unknown_outcome_unexplained",
            f"{rid}: outcome is 'unknown' with no matching missing_field_reasons entry",
        ))

    state = transition.get("state")
    if isinstance(state, dict) and state.get("artifact_hash") and state.get("inline") is not None:
        findings.append(_warn(
            "rl_transition_state_both_forms",
            f"{rid}: state carries both artifact_hash and inline — exactly one is expected",
        ))

    return findings


def check_episode_contiguity(transitions: list[dict[str, Any]]) -> list[Finding]:
    """Per-episode step_index must start at 0 and increment by 1 with no gaps or duplicates.

    Only checks records whose step_index is present (schema requires it, so this is really a
    dedup/ordering check, not a missing-data one).
    """
    findings: list[Finding] = []
    by_episode: dict[str, list[dict[str, Any]]] = {}
    for t in transitions:
        by_episode.setdefault(t.get("episode_id", "<unknown>"), []).append(t)

    for episode_id, steps in by_episode.items():
        ordered = sorted(steps, key=lambda t: t.get("step_index", -1))
        seen_indices = [t.get("step_index") for t in ordered]
        expected = list(range(len(ordered)))
        if seen_indices != expected:
            findings.append(_err(
                "rl_episode_step_gap",
                f"episode '{episode_id}': step_index values {seen_indices} are not a "
                f"contiguous 0..N-1 sequence",
            ))
        for t in ordered[:-1]:
            if t.get("terminated") is True or t.get("truncated") is True:
                findings.append(_err(
                    "rl_episode_terminal_not_last",
                    f"episode '{episode_id}': step {t.get('step_index')} is marked "
                    f"terminated/truncated but is not the episode's last step",
                ))
    return findings


def build_episode_manifest(transitions: list[dict[str, Any]]) -> list[dict[str, Any]]:
    """One summary row per episode_id: step count, packet linkage, terminal outcome, reward sum."""
    by_episode: dict[str, list[dict[str, Any]]] = {}
    for t in transitions:
        by_episode.setdefault(t.get("episode_id", "<unknown>"), []).append(t)

    manifest = []
    for episode_id, steps in sorted(by_episode.items()):
        ordered = sorted(steps, key=lambda t: t.get("step_index", -1))
        last = ordered[-1]
        rewards = [t["reward"] for t in ordered if t.get("reward") is not None]
        manifest.append({
            "episode_id": episode_id,
            "problem_version_id": last.get("problem_version_id"),
            "packet_id": last.get("packet_id"),
            "step_count": len(ordered),
            "terminated": last.get("terminated"),
            "truncated": last.get("truncated"),
            "terminal_outcome": last.get("outcome"),
            "reward_sum": sum(rewards) if rewards else None,
            "reward_known_step_count": len(rewards),
        })
    return manifest
