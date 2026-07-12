"""MCIP (MathCorpus Interchange Protocol) v1 record/bundle helpers.

Schemas live under ``schema/mcip/v1/``; see ``schema/mcip/v1/README.md`` for the protocol
description, canonicalization rules, and versioning policy. This module implements the hash
rule shared by every record type, plus the jsonschema registry shared by
``tools/validate_mcip.py`` and any other tool that needs to structurally validate one MCIP
record type (e.g. ``tools/validate_packets.py`` validating the restriction_profiles/
catalog) without re-implementing cross-file ``$ref`` resolution.
"""

from __future__ import annotations

import copy
import json
import sys
from pathlib import Path
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
    "literature_source": "literature_source.schema.json",
    "retrieved_passage": "retrieved_passage.schema.json",
    "external_claim": "external_claim.schema.json",
    "idea_attribution": "idea_attribution.schema.json",
    "prior_art_match": "prior_art_match.schema.json",
    "citation_review": "citation_review.schema.json",
    "contribution_statement": "contribution_statement.schema.json",
    "rl_transition": "rl_transition.schema.json",
}

SCHEMA_DIR = Path(__file__).resolve().parent.parent.parent / "schema" / "mcip" / "v1"


def record_hash(record: dict[str, Any]) -> str:
    """Stable ``record_hash`` over the canonical record, excluding ``record_hash`` itself.

    Mirrors ``mathcorpus.hashing.packet_hash``: every other field participates, so any
    content change changes the hash.
    """
    clone = copy.deepcopy(record)
    clone.pop("record_hash", None)
    return canonical_json_sha256(clone)


def load_jsonschema():
    """Import jsonschema + referencing, or exit with a clear message if missing."""
    try:
        import jsonschema
        from referencing import Registry, Resource
        from referencing.jsonschema import DRAFT202012
    except ImportError:
        print("ERROR: jsonschema not installed. `pip install -r tools/requirements.txt`", file=sys.stderr)
        raise SystemExit(2)
    return jsonschema, Registry, Resource, DRAFT202012


def build_schema_registry(schema_dir: Path = SCHEMA_DIR):
    """Load every ``schema/mcip/v1/*.schema.json`` file into a $ref-resolving registry.

    Returns ``(schemas_by_filename, registry)``. ``schemas_by_filename`` is keyed by e.g.
    ``"restriction_profile.schema.json"``; ``registry`` resolves cross-file ``$ref``s by
    ``$id`` for any validator built from one of those schemas.
    """
    jsonschema_mod, Registry, Resource, DRAFT202012 = load_jsonschema()
    schemas: dict[str, dict[str, Any]] = {}
    resources = []
    for path in sorted(schema_dir.glob("*.schema.json")):
        contents = json.loads(path.read_text(encoding="utf-8"))
        schemas[path.name] = contents
        resources.append((contents["$id"], Resource.from_contents(contents, default_specification=DRAFT202012)))
    registry = Registry().with_resources(resources)
    return schemas, registry


def validator_for_schema_file(filename: str, schema_dir: Path = SCHEMA_DIR):
    """A jsonschema validator for one ``schema/mcip/v1/*.schema.json`` file by name."""
    jsonschema_mod, _Registry, _Resource, _DRAFT = load_jsonschema()
    schemas, registry = build_schema_registry(schema_dir)
    schema = schemas[filename]
    cls = jsonschema_mod.validators.validator_for(schema)
    cls.check_schema(schema)
    return cls(schema, registry=registry)
