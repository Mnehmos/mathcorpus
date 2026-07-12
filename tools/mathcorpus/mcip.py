"""MCIP (MathCorpus Interchange Protocol) v1 record/bundle helpers.

Schemas live under ``schema/mcip/v1/``; see ``schema/mcip/v1/README.md`` for the protocol
description, canonicalization rules, and versioning policy. This module only implements the
hash rule shared by every record type — structural + cross-record validation lives in
``tools/validate_mcip.py``.
"""

from __future__ import annotations

import copy
from typing import Any

from .canonical import canonical_json_sha256

RECORD_TYPE_TO_SCHEMA_FILE = {
    "packet_identity": "packet_identity.schema.json",
    "proof_variant": "proof_variant.schema.json",
    "proof_profile": "proof_profile.schema.json",
    "restriction_profile": "restriction_profile.schema.json",
    "dependency_manifest": "dependency_manifest.schema.json",
    "attempt_record": "attempt_record.schema.json",
    "negative_example": "negative_example.schema.json",
    "repair_trajectory": "repair_trajectory.schema.json",
    "model_run": "model_run.schema.json",
    "empirical_difficulty_aggregate": "empirical_difficulty_aggregate.schema.json",
}


def record_hash(record: dict[str, Any]) -> str:
    """Stable ``record_hash`` over the canonical record, excluding ``record_hash`` itself.

    Mirrors ``mathcorpus.hashing.packet_hash``: every other field participates, so any
    content change changes the hash.
    """
    clone = copy.deepcopy(record)
    clone.pop("record_hash", None)
    return canonical_json_sha256(clone)
