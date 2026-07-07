"""Packet-level hash computation.

Two kinds of hash (kept deliberately separate):

* **semantic-ish** hashes over a controlled canonical serialization
  (``packet_sha256``, ``formal_statement_sha256``);
* **source** hashes over exact file bytes (``proof_body_sha256`` and friends), computed
  by :func:`mathcorpus.canonical.file_sha256`.
"""

from __future__ import annotations

import copy
from typing import Any

from .canonical import canonical_json_sha256

# Fields required to derive a formal-statement identity hash.
_FORMAL_STATEMENT_KEYS = ("theorem_name", "formal_statement_pp", "toolchain")


def formal_statement_hash(packet: dict[str, Any]) -> str | None:
    """SHA-256 over canonical JSON of ``{theorem_name, formal_statement_pp, toolchain}``.

    Returns ``None`` when the packet lacks the fields needed to identify a formal
    statement (e.g. a negative-example packet).
    """
    if not all(k in packet and packet[k] is not None for k in _FORMAL_STATEMENT_KEYS):
        return None
    obj = {k: packet[k] for k in _FORMAL_STATEMENT_KEYS}
    return canonical_json_sha256(obj)


def packet_hash(packet: dict[str, Any]) -> str:
    """Stable ``packet_sha256`` over the canonical packet, excluding ``packet_sha256``.

    ``hashes.packet_sha256`` is the only field removed before hashing (it cannot hash
    itself). All other fields — including the other identity hashes — participate, so a
    change to any of them changes the packet identity.
    """
    clone = copy.deepcopy(packet)
    hashes = clone.get("hashes")
    if isinstance(hashes, dict):
        hashes.pop("packet_sha256", None)
    return canonical_json_sha256(clone)


def compute_hashes(packet: dict[str, Any], *, proof_body_sha256: str | None = None) -> dict[str, Any]:
    """Return the ``hashes`` object this packet *should* have, given its content.

    Recomputes the derivable identity hashes (``formal_statement_sha256`` and, if a
    ``proof_body_sha256`` is supplied by the caller, that too), preserves any
    author-provided external-artifact hashes (``source_sha256``, ``canonical_cnf_sha256``,
    ``certificate_sha256``, ``private_artifact_bundle_sha256``, ``module_sha256``), then
    computes ``packet_sha256`` last over the assembled packet.
    """
    existing = dict(packet.get("hashes") or {})
    fsh = formal_statement_hash(packet)
    if fsh is not None:
        existing["formal_statement_sha256"] = fsh
    if proof_body_sha256 is not None:
        existing["proof_body_sha256"] = proof_body_sha256

    staged = copy.deepcopy(packet)
    staged["hashes"] = existing
    existing = dict(existing)
    existing["packet_sha256"] = packet_hash(staged)
    return existing
