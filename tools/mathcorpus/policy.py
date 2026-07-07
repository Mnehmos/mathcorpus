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

from dataclasses import dataclass
from typing import Any

from .hashing import formal_statement_hash, packet_hash

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
