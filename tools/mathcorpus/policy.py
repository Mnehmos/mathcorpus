"""Cross-field policy rules for MathCorpus packets.

The JSON Schema checks *structure* (types, enums, required keys). This module checks the
*relationships* between fields that make the corpus a trustworthy training asset:

* formal items carry the fields needed to rebuild and identify the proof;
* certificate-bearing packets bind a certificate to an exact canonical CNF;
* the encoding-soundness hard rule (formula facts are not math facts without a proved
  encoding lemma);
* trust rung / proof authority / status are mutually consistent;
* redaction flags do not contradict export permissions;
* negative examples are never proof-bearing;
* public packets carry a license;
* packets sharing a template family land in the same split (leakage control).

Each check yields :class:`Finding` objects at ``error`` (blocks release) or ``warn``.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Any

from .hashing import formal_statement_hash, packet_hash, repair_step_hash

PACKET_ID_RE = re.compile(r"^[a-z0-9]+([._][a-z0-9]+)*\.v[0-9]+$")

_DEP_CATEGORY_TO_ARRAY = {
    "declared": "declared_theorem_deps",
    "used": "used_theorem_deps",
    "obligation": "obligation_deps",
    "verified_module_item": "verified_module_item_deps",
    "retrieval_candidate": "retrieval_candidates",
    "retrieved_unused": "retrieved_unused_candidates",
}

# --- taxonomy constants -----------------------------------------------------------

FORMAL_KINDS = {
    "theorem", "exercise", "certificate_claim", "benchmark_item", "frontier_artifact",
}
PUBLIC_ELIGIBILITY = {"public_train", "public_val", "public_test"}
PUBLIC_OR_HELDOUT = PUBLIC_ELIGIBILITY | {"heldout_public"}
QUARANTINE_ELIGIBILITY = {"quarantined", "quarantined_benchmark", "private_audit_only", "disallowed"}

# rung -> the proof_authority it implies
RUNG_AUTHORITY = {
    0: {"none"},
    1: {"lean_kernel"},
    2: {"lean_verified_lrat"},
    3: {"kernel_rechecked_witness"},
    4: {"lean_verified_lrat"},
    5: {"none"},
}
# status -> allowed proof_authority values
STATUS_AUTHORITY = {
    "kernel_verified": {"lean_kernel"},
    "verified_certificate": {"lean_verified_lrat", "kernel_rechecked_witness"},
    "failed_attempt": {"none"},
    "redacted_public_metadata_only": {"lean_kernel", "lean_verified_lrat", "kernel_rechecked_witness", "none"},
    "formula_fact_only": {"lean_verified_lrat", "kernel_rechecked_witness", "none"},
    "empirical_only": {"none"},
}


@dataclass
class Finding:
    level: str  # "error" | "warn"
    code: str
    message: str

    def __str__(self) -> str:  # pragma: no cover - display only
        return f"[{self.level}] {self.code}: {self.message}"


def _err(code: str, msg: str) -> Finding:
    return Finding("error", code, msg)


def _warn(code: str, msg: str) -> Finding:
    return Finding("warn", code, msg)


def is_formal(packet: dict[str, Any]) -> bool:
    """A packet is 'formal' if its kind requires a proof, or it names a Lean artifact."""
    if packet.get("kind") in FORMAL_KINDS:
        return True
    return bool(packet.get("lean_module") or packet.get("theorem_name"))


def _encoding_view(packet: dict[str, Any]) -> dict[str, Any]:
    """Merge encoding fields, which may live under `encoding_soundness` or `trust`."""
    view: dict[str, Any] = {}
    for src in ("trust", "encoding_soundness"):
        obj = packet.get(src)
        if isinstance(obj, dict):
            for key in (
                "encoding_required", "encoding_soundness_status",
                "formula_fact_status", "math_fact_status",
            ):
                if obj.get(key) is not None:
                    view[key] = obj[key]
    return view


# --- per-packet checks ------------------------------------------------------------

def check_packet(packet: dict[str, Any]) -> list[Finding]:
    findings: list[Finding] = []
    kind = packet.get("kind")
    status = packet.get("status")
    trust = packet.get("trust") or {}
    training = packet.get("training") or {}
    hashes = packet.get("hashes") or {}
    prov = packet.get("source_provenance") or {}

    # 1. Formal items must be reconstructible + identifiable.
    if is_formal(packet):
        for field in ("lean_module", "theorem_name", "imports", "toolchain", "formal_statement_pp"):
            if not packet.get(field):
                findings.append(_err("formal_field_missing", f"formal item requires '{field}'"))
        if not hashes.get("formal_statement_sha256"):
            findings.append(_err("formal_statement_hash_missing",
                                  "formal item requires hashes.formal_statement_sha256"))

    # 2. Certificate binding: a cert hash without a canonical CNF hash is insufficient.
    cert = packet.get("certificate")
    cert_expected = kind == "certificate_claim" or (isinstance(cert, dict) and cert.get("certificate_type") not in (None, "none"))
    if cert_expected:
        if not isinstance(cert, dict):
            findings.append(_err("certificate_missing", f"kind '{kind}' requires a certificate object"))
        else:
            if not cert.get("certificate_sha256"):
                findings.append(_err("certificate_sha_missing", "certificate requires certificate_sha256"))
            if not cert.get("canonical_cnf_sha256"):
                findings.append(_err("cnf_hash_missing",
                                     "certificate must bind to an exact formula: canonical_cnf_sha256 required"))
            if not cert.get("dimacs_serializer_version"):
                findings.append(_warn("dimacs_version_missing",
                                      "record dimacs_serializer_version for reproducible CNF hashing"))

    # 3. Encoding-soundness HARD RULE.
    enc = _encoding_view(packet)
    if enc.get("encoding_required") is True and enc.get("encoding_soundness_status") != "proved":
        if enc.get("math_fact_status") != "formula_fact_only":
            findings.append(_err("encoding_unsound_math_claim",
                                 "encoding_required=true and encoding not proved: math_fact_status must be 'formula_fact_only'"))
        if status in ("kernel_verified", "verified_certificate"):
            findings.append(_err("encoding_unsound_status",
                                 f"encoding not proved: packet may not carry status '{status}' as a mathematical theorem"))

    # 4. Trust rung / proof_authority consistency.
    rung = trust.get("rung")
    authority = trust.get("proof_authority")
    if rung in RUNG_AUTHORITY and authority is not None and authority not in RUNG_AUTHORITY[rung]:
        expect = " or ".join(sorted(RUNG_AUTHORITY[rung]))
        findings.append(_err("rung_authority_mismatch",
                             f"trust.rung {rung} implies proof_authority {expect}, got '{authority}'"))

    # 5. Status / proof_authority consistency.
    if status in STATUS_AUTHORITY and authority is not None and authority not in STATUS_AUTHORITY[status]:
        expect = " or ".join(sorted(STATUS_AUTHORITY[status]))
        findings.append(_err("status_authority_mismatch",
                             f"status '{status}' implies proof_authority {expect}, got '{authority}'"))

    # 6. Redaction consistency.
    if packet.get("proof_body_redacted") is True and training.get("can_export_proof_body") is True:
        findings.append(_err("redaction_contradiction",
                             "proof_body_redacted=true but training.can_export_proof_body=true"))

    # 7. Negative examples are never proof-bearing.
    if kind == "negative_example":
        if status != "failed_attempt":
            findings.append(_err("negative_status", "negative_example requires status 'failed_attempt'"))
        if rung not in (0, None) and rung != 0:
            findings.append(_err("negative_rung", "negative_example requires trust.rung 0"))
        if training.get("eligibility") != "negative_example_only":
            findings.append(_err("negative_eligibility",
                                 "negative_example requires training.eligibility 'negative_example_only'"))

    # 8. Public packets need a license basis.
    eligibility = training.get("eligibility")
    if eligibility in PUBLIC_OR_HELDOUT:
        if not (prov.get("license_spdx") or prov.get("license_content")):
            findings.append(_err("public_license_missing",
                                 "public/heldout packet requires source_provenance license_spdx or license_content"))
        if not (prov.get("authors") or prov.get("source_refs")):
            findings.append(_err("public_provenance_missing",
                                 "public/heldout packet requires an authorship or source record"))

    # 9. Open-problem / benchmark items should not be publicly eligible (fail-closed nudge).
    if training.get("open_problem_related") is True and eligibility in PUBLIC_ELIGIBILITY:
        findings.append(_warn("open_problem_public",
                              "open_problem_related=true but eligibility is public_*; default should be quarantined"))
    if training.get("benchmark_tags") and eligibility in PUBLIC_ELIGIBILITY:
        findings.append(_warn("benchmark_public",
                              "benchmark_tags present but eligibility is public_*; consider quarantine"))

    # 10. Proof variants must not silently disagree with their parent packet's own evidence.
    findings.extend(check_proof_variants(packet))

    # 11. Dependency manifest internal consistency.
    findings.extend(check_dependency_manifest(packet))

    # 12. Attempts / negative examples / repair trajectories internal consistency.
    findings.extend(check_attempts_and_repairs(packet))

    return findings


def check_attempts_and_repairs(packet: dict[str, Any]) -> list[Finding]:
    """attempts / negative_examples / repair_trajectories must reference each other
    consistently within one packet. Cross-packet terminal_ref resolution (when a repair's
    successful proof was filed as its own packet) is checked corpus-wide by
    check_repair_trajectory_refs, since it needs the full packet list.
    """
    findings: list[Finding] = []
    attempts = packet.get("attempts") or []
    attempt_ids = {a.get("attempt_id") for a in attempts if a.get("attempt_id")}
    variant_ids = {v.get("variant_id") for v in (packet.get("proof_variants") or []) if v.get("variant_id")}
    attempts_by_id = {a.get("attempt_id"): a for a in attempts if a.get("attempt_id")}

    for i, ne in enumerate(packet.get("negative_examples") or []):
        aid = ne.get("attempt_id")
        if aid not in attempt_ids:
            findings.append(_err("negative_example_dangling_attempt",
                                 f"negative_examples[{i}] references attempt_id '{aid}' "
                                 "which is not in this packet's own 'attempts'"))
        elif ne.get("diagnostic_category") is not None:
            attempt_cat = attempts_by_id.get(aid, {}).get("diagnostic_category")
            if attempt_cat is not None and ne["diagnostic_category"] != attempt_cat:
                findings.append(_warn("negative_example_diagnostic_category_mismatch",
                                      f"negative_examples[{i}].diagnostic_category "
                                      f"('{ne['diagnostic_category']}') disagrees with its "
                                      f"attempt's diagnostic_category ('{attempt_cat}')"))

    for ti, traj in enumerate(packet.get("repair_trajectories") or []):
        steps = traj.get("steps") or []
        prev_index = None
        for si, step in enumerate(steps):
            idx = step.get("step_index")
            if prev_index is not None and idx is not None and idx <= prev_index:
                findings.append(_err("repair_trajectory_steps_unordered",
                                     f"repair_trajectories[{ti}].steps[{si}] has step_index {idx}, "
                                     f"not strictly greater than the previous step's {prev_index}"))
            prev_index = idx if idx is not None else prev_index

            if step.get("from_attempt_id") not in attempt_ids:
                findings.append(_err("repair_step_dangling_from_attempt",
                                     f"repair_trajectories[{ti}].steps[{si}].from_attempt_id "
                                     f"'{step.get('from_attempt_id')}' is not in this packet's own 'attempts'"))
            to_ref = step.get("to_ref")
            if to_ref not in attempt_ids and to_ref not in variant_ids:
                findings.append(_err("repair_step_dangling_to_ref",
                                     f"repair_trajectories[{ti}].steps[{si}].to_ref '{to_ref}' is "
                                     "not an attempt_id or proof_variants[].variant_id in this same packet"))

            expected_hash = repair_step_hash(step)
            if step.get("step_hash") != expected_hash:
                findings.append(_err("repair_step_hash_stale",
                                     f"repair_trajectories[{ti}].steps[{si}].step_hash does not match "
                                     "recompute over {step_index, from_attempt_id, repair_action, "
                                     "diagnostic_category_addressed, to_ref}"))

        terminal_ref = traj.get("terminal_ref")
        terminal_outcome = traj.get("terminal_outcome")
        locally_resolved = (
            (terminal_outcome == "verified_proof" and terminal_ref in variant_ids)
            or (terminal_outcome == "explicit_failure" and terminal_ref in attempt_ids)
        )
        if not locally_resolved and not PACKET_ID_RE.match(terminal_ref or ""):
            findings.append(_err("repair_trajectory_terminal_ref_unresolved",
                                 f"repair_trajectories[{ti}].terminal_ref '{terminal_ref}' resolves "
                                 f"neither locally (for outcome '{terminal_outcome}') nor as a "
                                 "cross-packet packet_id"))

    return findings


# --- corpus-wide repair-trajectory checks -------------------------------------------

def check_repair_trajectory_refs(packets: list[dict[str, Any]]) -> list[Finding]:
    """A repair_trajectory's terminal_ref that points to another packet (packet-id-shaped,
    not resolved locally) must resolve to a real packet in the corpus.
    """
    findings: list[Finding] = []
    known_ids = {p.get("packet_id") for p in packets if p.get("packet_id")}

    for p in packets:
        pid = p.get("packet_id", "<unknown>")
        variant_ids = {v.get("variant_id") for v in (p.get("proof_variants") or []) if v.get("variant_id")}
        attempt_ids = {a.get("attempt_id") for a in (p.get("attempts") or []) if a.get("attempt_id")}
        for ti, traj in enumerate(p.get("repair_trajectories") or []):
            terminal_ref = traj.get("terminal_ref")
            terminal_outcome = traj.get("terminal_outcome")
            locally_resolved = (
                (terminal_outcome == "verified_proof" and terminal_ref in variant_ids)
                or (terminal_outcome == "explicit_failure" and terminal_ref in attempt_ids)
            )
            if locally_resolved or not PACKET_ID_RE.match(terminal_ref or ""):
                continue
            if terminal_ref not in known_ids:
                findings.append(_err("repair_trajectory_dangling_cross_packet_ref",
                                     f"{pid}: repair_trajectories[{ti}].terminal_ref references "
                                     f"packet_id '{terminal_ref}' which is not in the corpus"))

    return findings


def check_dependency_manifest(packet: dict[str, Any]) -> list[Finding]:
    """A dependency_manifest's own claims must be internally consistent.

    Declared, retrieved, and used dependencies must remain distinct categories: a claim's
    ``dependency_id`` must actually appear in the array its ``category`` names, and a
    dependency cannot simultaneously be 'used' and 'retrieved but unused' — that is a direct
    contradiction in the evidence, not a matter of taste.
    """
    findings: list[Finding] = []
    dm = packet.get("dependency_manifest")
    if not dm:
        return findings

    env = dm.get("environment_hash")
    packet_env = (packet.get("verification") or {}).get("environment_hash")
    if env is not None and packet_env is not None and env != packet_env:
        findings.append(_err("dependency_manifest_environment_mismatch",
                             "dependency_manifest.environment_hash does not match "
                             "the parent packet's verification.environment_hash"))

    used = set(dm.get("used_theorem_deps") or [])
    unused = set(dm.get("retrieved_unused_candidates") or [])
    overlap = used & unused
    if overlap:
        findings.append(_err("dependency_manifest_used_unused_contradiction",
                             f"dependency ids claimed both used and retrieved-unused: {sorted(overlap)}"))

    for i, claim in enumerate(dm.get("claim_sources") or []):
        category = claim.get("category")
        array_field = _DEP_CATEGORY_TO_ARRAY.get(category)
        dep_id = claim.get("dependency_id")
        if array_field and dep_id not in (dm.get(array_field) or []):
            findings.append(_err("dependency_claim_source_unlisted",
                                 f"claim_sources[{i}] claims '{dep_id}' as category '{category}' "
                                 f"but it is not present in dependency_manifest.{array_field}"))

    return findings


# --- corpus-wide dependency-manifest checks -----------------------------------------

def check_dependency_manifest_refs(packets: list[dict[str, Any]]) -> list[Finding]:
    """Cross-packet checks over dependency_manifest that need the whole corpus.

    Only dependency ids shaped like a MathCorpus packet_id are checkable against the
    corpus (Mathlib declaration names are not resolvable here); those must resolve to a
    real packet (no dangling references) and must not form a cycle.
    """
    findings: list[Finding] = []
    known_ids = {p.get("packet_id") for p in packets if p.get("packet_id")}
    graph: dict[str, set[str]] = {}

    for p in packets:
        pid = p.get("packet_id", "<unknown>")
        dm = p.get("dependency_manifest")
        if not dm:
            continue
        referenced: set[str] = set()
        for field in ("used_theorem_deps", "verified_module_item_deps", "obligation_deps", "declared_theorem_deps"):
            for dep in dm.get(field) or []:
                if PACKET_ID_RE.match(dep):
                    referenced.add(dep)
                    if dep not in known_ids:
                        findings.append(_err("dependency_manifest_dangling_ref",
                                             f"{pid}: dependency_manifest.{field} references "
                                             f"packet_id '{dep}' which is not in the corpus"))
        graph[pid] = referenced

    seen_cycles: set[frozenset[tuple[str, str]]] = set()
    for start in graph:
        stack = [(start, [start])]
        while stack:
            node, path = stack.pop()
            for nxt in graph.get(node, ()):
                if nxt == start:
                    cycle_nodes = path + [nxt]
                    edges = frozenset(zip(cycle_nodes, cycle_nodes[1:]))
                    if edges not in seen_cycles:
                        seen_cycles.add(edges)
                        findings.append(_err("dependency_manifest_cycle",
                                             "dependency cycle through MathCorpus packet references: "
                                             + " -> ".join(cycle_nodes)))
                elif nxt not in path:
                    stack.append((nxt, path + [nxt]))

    return findings


def check_proof_variants(packet: dict[str, Any]) -> list[Finding]:
    """A variant's statement/environment/proof hash must match its parent packet.

    A variant is *additional* evidence — it may never claim to prove a different
    statement, under a different environment, than the packet it is attached to. The
    canonical variant additionally must reproduce the packet's own recorded proof hash,
    since 'canonical' means 'the packet's own proof, restated as a variant record'.
    """
    findings: list[Finding] = []
    variants = packet.get("proof_variants")
    if not variants:
        return findings

    hashes = packet.get("hashes") or {}
    packet_fsh = hashes.get("formal_statement_sha256")
    packet_env = (packet.get("verification") or {}).get("environment_hash")
    packet_proof_sha = hashes.get("proof_body_sha256")

    for i, v in enumerate(variants):
        vid = v.get("variant_id", f"#{i}")
        vfsh = v.get("formal_statement_sha256")
        if vfsh is not None and packet_fsh is not None and vfsh != packet_fsh:
            findings.append(_err("variant_statement_hash_mismatch",
                                 f"proof_variants[{vid}].formal_statement_sha256 does not match "
                                 "the parent packet's hashes.formal_statement_sha256"))
        venv = v.get("environment_hash")
        if venv is not None and packet_env is not None and venv != packet_env:
            findings.append(_err("variant_environment_hash_mismatch",
                                 f"proof_variants[{vid}].environment_hash does not match "
                                 "the parent packet's verification.environment_hash"))
        if v.get("variant_style") == "canonical":
            vproof = v.get("proof_body_sha256")
            if vproof is not None and packet_proof_sha is not None and vproof != packet_proof_sha:
                findings.append(_err("variant_proof_hash_mismatch",
                                     f"proof_variants[{vid}] is styled 'canonical' but its "
                                     "proof_body_sha256 does not match the parent packet's "
                                     "hashes.proof_body_sha256"))

    return findings


# --- restriction-profile catalog checks --------------------------------------------

def check_restriction_profile_refs(
    packets: list[dict[str, Any]], restriction_profiles: dict[str, dict[str, Any]]
) -> list[Finding]:
    """Every restricted variant's (id, hash) pin must resolve in the shared catalog.

    ``restriction_profiles`` maps ``record_id`` -> the loaded restriction_profile record
    (see ``restriction_profiles/`` and ``schema/mcip/v1/restriction_profile.schema.json``).
    """
    findings: list[Finding] = []
    for p in packets:
        pid = p.get("packet_id", "<unknown>")
        for v in p.get("proof_variants") or []:
            rp_id = v.get("restriction_profile_id")
            if rp_id is None:
                continue
            entry = restriction_profiles.get(rp_id)
            if entry is None:
                findings.append(_err("restriction_profile_dangling",
                                     f"{pid}: proof_variants references restriction_profile_id "
                                     f"'{rp_id}' which is not in the restriction_profiles/ catalog"))
                continue
            pinned = v.get("restriction_profile_sha256")
            actual = entry.get("record_hash")
            if pinned is not None and pinned != actual:
                findings.append(_err("restriction_profile_hash_stale",
                                     f"{pid}: proof_variants pins restriction_profile_id '{rp_id}' "
                                     f"at hash {pinned}, but the catalog entry's current record_hash "
                                     f"is {actual} (run tools/stamp_restriction_profiles.py or update the pin)"))
    return findings


# --- corpus-wide checks -----------------------------------------------------------

def check_corpus(packets: list[dict[str, Any]]) -> list[Finding]:
    """Checks that need the whole corpus: duplicate ids and template-locked splits."""
    findings: list[Finding] = []

    # Duplicate packet_id.
    seen: dict[str, int] = {}
    for p in packets:
        pid = p.get("packet_id")
        if pid is None:
            continue
        seen[pid] = seen.get(pid, 0) + 1
    for pid, n in seen.items():
        if n > 1:
            findings.append(_err("duplicate_packet_id", f"packet_id '{pid}' appears {n} times"))

    # Template-locked split family: all non-quarantined members of a template family
    # must share one split family, else near-duplicates can leak across the boundary.
    families: dict[str, set[str]] = {}
    for p in packets:
        training = p.get("training") or {}
        fam = training.get("template_family_id")
        elig = training.get("eligibility")
        if not fam or elig in QUARANTINE_ELIGIBILITY or elig == "negative_example_only":
            continue
        families.setdefault(fam, set()).add(_split_family(elig, training.get("split")))
    for fam, splits in families.items():
        if len(splits) > 1:
            findings.append(_err("template_split_leak",
                                 f"template_family_id '{fam}' spans multiple split families {sorted(splits)}; "
                                 "template families must not cross split boundaries"))

    return findings


def _split_family(eligibility: str | None, split: str | None) -> str:
    if split:
        return "train" if split in ("train", "val") else split
    mapping = {
        "public_train": "train",
        "public_val": "train",
        "public_test": "test_public",
        "heldout_public": "heldout_public",
    }
    return mapping.get(eligibility or "", eligibility or "unknown")


def hash_mismatches(packet: dict[str, Any]) -> list[Finding]:
    """Compare stored identity hashes against a fresh recompute (used by --check-hashes)."""
    findings: list[Finding] = []
    hashes = packet.get("hashes") or {}
    fsh = formal_statement_hash(packet)
    if fsh is not None and hashes.get("formal_statement_sha256") not in (None, fsh):
        findings.append(_err("formal_statement_hash_stale",
                             "hashes.formal_statement_sha256 does not match recompute (run stamp_hashes.py)"))
    expected_packet = packet_hash(packet)
    if hashes.get("packet_sha256") != expected_packet:
        findings.append(_err("packet_hash_stale",
                             "hashes.packet_sha256 does not match recompute (run stamp_hashes.py)"))
    return findings
