"""Fold MCIP v1 records into a MathCorpus packet's own child-record fields.

Shared core for ``tools/import_mcip.py`` (importing bundles into existing corpus packets)
and ``tools/author_packet.py`` (folding a verifier-export bundle into a newly-authored
packet). This module never touches a packet's canonical identity fields (``packet_id``,
``title``, ``theorem_name``, ``formal_statement_pp``, ``hashes``, ``trust``, ``training``,
...) — only the child-record arrays/objects added by issues #2-#5. Restriction-profile
records are not folded into a packet at all; they go to the shared ``restriction_profiles/``
catalog instead (see ``schema/ENUMS.md#restriction-profiles``).
"""

from __future__ import annotations

import copy
import json
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

_ENVELOPE_FIELDS = {
    "schema_version", "record_type", "record_id", "packet_id", "environment_hash",
    "artifact_hashes", "created_at", "trust_status", "export_eligibility", "record_hash",
}


def _strip_envelope(record: dict[str, Any]) -> dict[str, Any]:
    return {k: v for k, v in record.items() if k not in _ENVELOPE_FIELDS}


def fold_proof_variant(record: dict[str, Any], proof_profile_record: dict[str, Any] | None) -> dict[str, Any]:
    body = _strip_envelope(record)
    body.pop("proof_profile_id", None)
    if "restriction_profile_hash" in body:
        body["restriction_profile_sha256"] = body.pop("restriction_profile_hash")
    out = {"variant_id": record["record_id"], **body}
    if proof_profile_record is not None:
        pp = _strip_envelope(proof_profile_record)
        pp.pop("proof_variant_id", None)
        out["proof_profile"] = pp
    return out


def fold_dependency_manifest(record: dict[str, Any]) -> tuple[dict[str, Any], dict[str, list[str]]]:
    """Returns ``(dependency_manifest_body, dependencies_extra)``.

    ``dependencies_extra`` holds ``kits``/``tactic_tags``/``prerequisite_concepts`` — MCIP
    keeps these on the manifest record, but ``packet.schema.json`` keeps them on the
    packet's shallow top-level ``dependencies`` object instead (see #3). The caller merges
    ``dependencies_extra`` into ``packet["dependencies"]``.
    """
    body = _strip_envelope(record)
    body.pop("proof_variant_id", None)
    extra = {
        "kits": body.pop("kits", []) or [],
        "tactic_tags": body.pop("tactic_tags", []) or [],
        "prerequisite_concepts": body.pop("prerequisite_concepts", []) or [],
    }
    return body, extra


def fold_attempt_record(record: dict[str, Any]) -> dict[str, Any]:
    body = _strip_envelope(record)
    body.pop("public_metadata", None)
    return {"attempt_id": record["record_id"], **body}


def fold_negative_example(record: dict[str, Any]) -> dict[str, Any]:
    body = _strip_envelope(record)
    return {"negative_id": record["record_id"], **body}


def fold_repair_trajectory(record: dict[str, Any]) -> dict[str, Any]:
    body = _strip_envelope(record)
    return {"trajectory_id": record["record_id"], **body}


def fold_model_run(record: dict[str, Any]) -> dict[str, Any]:
    body = _strip_envelope(record)
    body.pop("public_metadata", None)
    body.setdefault("censored_fields", [])
    return {"model_run_id": record["record_id"], **body}


def fold_empirical_difficulty_aggregate(record: dict[str, Any]) -> dict[str, Any]:
    body = _strip_envelope(record)
    body.pop("model_config_hash", None)  # not part of the packet-embedded shape
    body.pop("public_metadata", None)
    return {"aggregate_id": record["record_id"], **body}


# field on the packet, id key within each entry, and whether the field is a single object
# (dependency_manifest) rather than an array.
_PACKET_FIELD_BY_RECORD_TYPE = {
    "proof_variant": ("proof_variants", "variant_id", False),
    "dependency_manifest": ("dependency_manifest", None, True),
    "attempt_record": ("attempts", "attempt_id", False),
    "negative_example": ("negative_examples", "negative_id", False),
    "repair_trajectory": ("repair_trajectories", "trajectory_id", False),
    "model_run": ("model_runs", "model_run_id", False),
    "empirical_difficulty_aggregate": ("empirical_difficulty_aggregates", "aggregate_id", False),
}

# MCIP record types a real proof-search bundle legitimately carries but this importer does
# not fold onto a packet: rl_transitions are RL training data exported separately, and
# literature_source/idea_attribution provenance folds only once its cross-repo catalog
# linkage is aligned (see the #263 follow-up). Recognized-and-skipped, never an error — so
# their presence does not abort the fold of the proof/dependency/attempt evidence.
_RECOGNIZED_NOT_FOLDED = frozenset({"rl_transition", "literature_source", "idea_attribution"})


@dataclass
class ImportResult:
    applied: list[tuple[str, str]] = field(default_factory=list)          # (field, id)
    skipped_idempotent: list[tuple[str, str]] = field(default_factory=list)  # already present, identical
    conflicts: list[tuple[str, str, str]] = field(default_factory=list)   # (field, id, reason)
    restriction_profiles: list[dict[str, Any]] = field(default_factory=list)
    skipped_unfolded: list[tuple[str, str]] = field(default_factory=list)  # (record_type, id) recognized, not folded
    errors: list[str] = field(default_factory=list)


def fold_bundle_into_packet(bundle: dict[str, Any], packet: dict[str, Any]) -> ImportResult:
    """Apply every foldable record in ``bundle`` directly onto ``packet``, in place.

    Mutates ``packet`` — callers that must not touch an existing file's in-memory dict
    (e.g. to preserve an untouched copy for comparison, or to discard the whole import on
    error) should pass a copy, not the original. Never writes to a packet's own canonical
    identity fields (packet_id, title, theorem_name, formal_statement_pp, hashes, trust,
    training, ...) — only the child-record fields added by issues #2-#5. See
    ``tools/import_mcip.py`` for the "never mutate canonical identity" + conflict-quarantine
    orchestration built around this function.
    """
    result = ImportResult()
    records = bundle.get("records") or []

    identities = [r for r in records if r.get("record_type") == "packet_identity"]
    if len(identities) != 1:
        result.errors.append(f"bundle must have exactly one packet_identity record, found {len(identities)}")
        return result
    identity = identities[0]

    # The bundle's packet_identity.formal_statement_sha256 is the RAW SHA-256 of the
    # environment's registered root statement. A MathCorpus packet's own
    # hashes.formal_statement_sha256 is a canonical-JSON hash over
    # {theorem_name, formal_statement_pp, toolchain} — a different function, so the two
    # are never equal for a real proof-search bundle. When the packet declares the
    # registered-statement hash (verification.root_statement_sha256), compare the bundle
    # against THAT like-for-like; only fall back to the legacy hashes.formal_statement_sha256
    # comparison when it is absent, so pre-bridge fixtures/packets still validate (#13).
    registered_fsh = (packet.get("verification") or {}).get("root_statement_sha256")
    packet_fsh = (packet.get("hashes") or {}).get("formal_statement_sha256")
    identity_fsh = identity.get("formal_statement_sha256")
    if registered_fsh is not None and identity_fsh is not None:
        if registered_fsh != identity_fsh:
            result.errors.append(
                f"packet_identity.formal_statement_sha256 ({identity_fsh}) does not match the "
                f"target packet's verification.root_statement_sha256 ({registered_fsh}) — "
                "refusing to import evidence for a statement mismatch"
            )
            return result
    elif packet_fsh is not None and identity_fsh is not None and packet_fsh != identity_fsh:
        result.errors.append(
            f"packet_identity.formal_statement_sha256 ({identity_fsh}) does not match "
            f"target packet's hashes.formal_statement_sha256 ({packet_fsh}) — refusing to "
            "import evidence for a statement mismatch"
        )
        return result

    proof_profiles_by_variant_id = {
        r["proof_variant_id"]: r for r in records
        if r.get("record_type") == "proof_profile" and r.get("proof_variant_id")
    }

    for r in records:
        rtype = r.get("record_type")
        if rtype in (None, "packet_identity", "proof_profile"):
            continue  # proof_profile is folded via its owning proof_variant, not standalone
        if rtype == "restriction_profile":
            result.restriction_profiles.append(r)
            continue
        if rtype in _RECOGNIZED_NOT_FOLDED:
            # A real proof-search bundle carries these, but a packet does not store them
            # as foldable child records: rl_transitions are exported as RL training data,
            # not into a packet; literature_source/idea_attribution provenance folds only
            # once its cross-repo catalog linkage is aligned (record_id linkage + record_hash
            # pinning — see the #263 follow-up). Recognized and skipped so their presence
            # never aborts the fold of the evidence that DOES belong on the packet.
            result.skipped_unfolded.append((rtype, r.get("record_id", "<unknown>")))
            continue
        if rtype not in _PACKET_FIELD_BY_RECORD_TYPE:
            result.errors.append(f"unknown record_type '{rtype}' — not folded")
            continue

        field_name, id_key, is_singular = _PACKET_FIELD_BY_RECORD_TYPE[rtype]

        if rtype == "proof_variant":
            folded = fold_proof_variant(r, proof_profiles_by_variant_id.get(r["record_id"]))
        elif rtype == "dependency_manifest":
            folded, extra = fold_dependency_manifest(r)
            deps = packet.setdefault("dependencies", {})
            for k, vals in extra.items():
                merged = list(dict.fromkeys((deps.get(k) or []) + vals))  # union, order-stable
                if merged:
                    deps[k] = merged
        elif rtype == "attempt_record":
            folded = fold_attempt_record(r)
        elif rtype == "negative_example":
            folded = fold_negative_example(r)
        elif rtype == "repair_trajectory":
            folded = fold_repair_trajectory(r)
        elif rtype == "model_run":
            folded = fold_model_run(r)
        elif rtype == "empirical_difficulty_aggregate":
            folded = fold_empirical_difficulty_aggregate(r)
        else:  # pragma: no cover - guarded by the membership check above
            continue

        record_id = r.get("record_id", "<unknown>")

        if is_singular:
            existing = packet.get(field_name)
            if existing is None:
                packet[field_name] = folded
                result.applied.append((field_name, record_id))
            elif existing == folded:
                result.skipped_idempotent.append((field_name, record_id))
            else:
                result.conflicts.append((field_name, record_id, "existing dependency_manifest differs"))
            continue

        target_list = packet.setdefault(field_name, [])
        existing_entry = next((e for e in target_list if e.get(id_key) == folded.get(id_key)), None)
        if existing_entry is None:
            target_list.append(folded)
            result.applied.append((field_name, record_id))
        elif existing_entry == folded:
            result.skipped_idempotent.append((field_name, record_id))
        else:
            result.conflicts.append((field_name, record_id, f"existing entry with {id_key}='{folded.get(id_key)}' differs"))

    return result


def import_restriction_profile(record: dict[str, Any], out_dir: Path) -> tuple[str, str]:
    """Write/verify one restriction_profile record against the shared catalog.

    Returns ``(status, record_id)`` where status is ``'applied'``, ``'skipped_idempotent'``,
    or ``'conflict'``. Idempotent: re-importing an identical record is a no-op; an existing
    catalog entry with the same ``record_id`` but different content is never overwritten.
    """
    record_id = record["record_id"]
    path = out_dir / f"{record_id}.json"
    # Prefer an existing file with this record_id if one is already in the catalog under a
    # different filename (e.g. the hand-authored naming convention), so re-imports don't
    # create duplicate catalog files.
    for existing in out_dir.glob("*.json") if out_dir.is_dir() else []:
        try:
            data = json.loads(existing.read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError):
            continue
        if data.get("record_id") == record_id:
            if data == record:
                return "skipped_idempotent", record_id
            return "conflict", record_id
    out_dir.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(record, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")
    return "applied", record_id
