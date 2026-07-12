"""Redaction-aware public export.

Turns an internal packet into a public row, or ``None`` if the packet is not publicly
eligible. Enforces the export-policy matrix (fail-closed): restricted proof bodies,
certificate files, solver models, benchmark CNF encodings, and private audit traces never
reach a public row.
"""

from __future__ import annotations

import copy
from typing import Any

from .policy import PUBLIC_ELIGIBILITY, implicit_publication_status

# Split each eligibility maps to on the public surface.
ELIGIBILITY_TO_SPLIT = {
    "public_train": "train",
    "public_val": "val",
    "public_test": "test_public",
    "heldout_public": "heldout_public",
}

# Certificate sub-fields that must never appear in a public export.
_CERT_FORBIDDEN = {"private_artifact_uri"}
# Top-level fields dropped from every public row.
_ALWAYS_DROP = {"review"}


def contribution_summary(packet: dict[str, Any]) -> str | None:
    """Human-readable rendering of contribution class + publication status + known prior
    art, for exports (issue #8: 'exports include a human-readable and machine-readable
    contribution statement'). The machine-readable form is the raw contribution_statements
    / publication fields, already present in the exported row.
    """
    statements = packet.get("contribution_statements") or []
    pub = packet.get("publication")
    if not statements and pub is None:
        return None
    parts = []
    if statements:
        latest = statements[-1]
        parts.append(f"Contribution class: {latest.get('contribution_class', 'unspecified')}.")
        prior = latest.get("known_prior_art_refs") or []
        if prior:
            parts.append(f"Known prior art: {', '.join(prior)}.")
    parts.append(f"Publication status: {(pub or {}).get('status') or implicit_publication_status(packet)}.")
    caveats = (pub or {}).get("unresolved_attribution_caveats") or []
    if caveats:
        parts.append(f"Unresolved caveats: {'; '.join(caveats)}.")
    return " ".join(parts)


def split_for(packet: dict[str, Any]) -> str | None:
    training = packet.get("training") or {}
    return ELIGIBILITY_TO_SPLIT.get(training.get("eligibility"))


def is_public(packet: dict[str, Any]) -> bool:
    return split_for(packet) is not None


def public_row(packet: dict[str, Any]) -> dict[str, Any] | None:
    """Return a redacted public row, or ``None`` if the packet is not publicly eligible."""
    training = packet.get("training") or {}
    eligibility = training.get("eligibility")
    split = ELIGIBILITY_TO_SPLIT.get(eligibility)
    if split is None:
        return None

    row = copy.deepcopy(packet)
    row["split"] = split

    for key in _ALWAYS_DROP:
        row.pop(key, None)

    # Proof body: withheld if redacted or export not permitted.
    can_export_body = training.get("can_export_proof_body", not packet.get("proof_body_redacted", False))
    if packet.get("proof_body_redacted") or can_export_body is False:
        row.pop("proof_body_path", None)
        row["proof_body_redacted"] = True

    # Heldout-public is statement-only: drop proof body + solution hints.
    if split == "heldout_public":
        row.pop("proof_body_path", None)
        row.pop("informal_proof_idea", None)
        row["proof_body_redacted"] = True

    # Certificate: keep metadata only if permitted; never the file/model/uri.
    cert = row.get("certificate")
    if isinstance(cert, dict):
        if training.get("can_export_certificate_metadata") is False:
            row["certificate"] = None
        else:
            for forbidden in _CERT_FORBIDDEN:
                cert.pop(forbidden, None)
            cert["certificate_artifact_redacted"] = True
            if training.get("can_export_certificate_file") is not True:
                # metadata + hashes stay; the file bytes are never referenced publicly
                cert.pop("certificate_artifact_path", None)

    # Private artifact inventory never ships.
    artifacts = row.get("artifacts")
    if isinstance(artifacts, dict):
        artifacts.pop("private_artifact_inventory", None)
        if not artifacts:
            row.pop("artifacts", None)

    # Private-artifact bundle hash is an internal audit anchor.
    hashes = row.get("hashes")
    if isinstance(hashes, dict):
        hashes.pop("private_artifact_bundle_sha256", None)

    row["contribution_summary"] = contribution_summary(packet)
    return row


def public_rows(packets: list[dict[str, Any]]) -> list[dict[str, Any]]:
    rows = [public_row(p) for p in packets]
    return [r for r in rows if r is not None]


def negative_row(packet: dict[str, Any]) -> dict[str, Any] | None:
    """Return a redacted row for a public-safe labeled negative example, else ``None``.

    Negative examples are non-proof-bearing (rung 0) but valuable training data. They are
    exported to a separate ``negative_examples.jsonl`` surface, never the split files.
    """
    training = packet.get("training") or {}
    trust = packet.get("trust") or {}
    if training.get("eligibility") != "negative_example_only":
        return None
    if trust.get("public_claim_class") != "public_safe":
        return None
    row = copy.deepcopy(packet)
    row["split"] = "negative_example"
    for key in _ALWAYS_DROP:
        row.pop(key, None)
    row.pop("proof_body_path", None)
    artifacts = row.get("artifacts")
    if isinstance(artifacts, dict):
        artifacts.pop("private_artifact_inventory", None)
    hashes = row.get("hashes")
    if isinstance(hashes, dict):
        hashes.pop("private_artifact_bundle_sha256", None)
    row["contribution_summary"] = contribution_summary(packet)
    return row


def negative_rows(packets: list[dict[str, Any]]) -> list[dict[str, Any]]:
    rows = [negative_row(p) for p in packets]
    return [r for r in rows if r is not None]


__all__ = [
    "public_row", "public_rows", "negative_row", "negative_rows",
    "is_public", "split_for", "contribution_summary", "ELIGIBILITY_TO_SPLIT", "PUBLIC_ELIGIBILITY",
]
