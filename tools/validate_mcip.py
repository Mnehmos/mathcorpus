#!/usr/bin/env python3
"""Validate MCIP (MathCorpus Interchange Protocol) v1 bundles.

Validates independently of Proof Search or its SQLite schema: only
``schema/mcip/v1/*.schema.json`` and the bundle file(s) given on the command line are
needed. See ``schema/mcip/v1/README.md`` for the protocol description.

Usage:
    python tools/validate_mcip.py schema/mcip/v1/fixtures/success_proof.bundle.json
    python tools/validate_mcip.py schema/mcip/v1/fixtures/ --check-hashes
    python tools/validate_mcip.py some_bundle.json --warn-as-error
"""

from __future__ import annotations

import argparse
import glob as _glob
import json
import sys
from pathlib import Path
from typing import Any

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus.mcip import (  # noqa: E402
    RECORD_TYPE_TO_SCHEMA_FILE,
    build_schema_registry,
    record_hash,
)

BUNDLE_SCHEMA_FILE = "bundle.schema.json"


def _validator_for(jsonschema_mod, registry, schema: dict[str, Any]):
    cls = jsonschema_mod.validators.validator_for(schema)
    cls.check_schema(schema)
    return cls(schema, registry=registry)


def _iter_bundle_paths(arg: str) -> list[Path]:
    p = Path(arg)
    if p.is_dir():
        return sorted(p.glob("*.json"))
    if p.is_file():
        return [p]
    return [Path(m) for m in sorted(_glob.glob(arg, recursive=True))]


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("paths", nargs="+", help="Bundle files or a directory of bundle files.")
    ap.add_argument("--check-hashes", action="store_true", help="Recompute and verify every record_hash.")
    ap.add_argument("--warn-as-error", action="store_true", help="Treat warnings as errors.")
    args = ap.parse_args()

    import jsonschema as jsonschema_mod

    schemas, registry = build_schema_registry()

    bundle_validator = _validator_for(jsonschema_mod, registry, schemas[BUNDLE_SCHEMA_FILE])
    record_validators = {
        record_type: _validator_for(jsonschema_mod, registry, schemas[fname])
        for record_type, fname in RECORD_TYPE_TO_SCHEMA_FILE.items()
    }

    bundle_paths: list[Path] = []
    for arg in args.paths:
        bundle_paths.extend(_iter_bundle_paths(arg))
    bundle_paths = sorted(set(bundle_paths))
    if not bundle_paths:
        print("No bundle files found.", file=sys.stderr)
        return 1

    n_error = 0
    n_warn = 0
    n_records = 0

    for bpath in bundle_paths:
        findings: list[str] = []
        try:
            bundle = json.loads(bpath.read_text(encoding="utf-8"))
        except json.JSONDecodeError as e:
            print(f"{bpath}:\n  [error] invalid JSON: {e}")
            n_error += 1
            continue

        for e in sorted(bundle_validator.iter_errors(bundle), key=lambda e: e.path):
            loc = "/".join(str(x) for x in e.path) or "<root>"
            findings.append(f"  [error] bundle schema at {loc}: {e.message}")
            n_error += 1

        for i, rec in enumerate(bundle.get("records") or []):
            n_records += 1
            rtype = rec.get("record_type") if isinstance(rec, dict) else None
            validator = record_validators.get(rtype)
            if validator is None:
                findings.append(f"  [error] records[{i}]: unknown or missing record_type {rtype!r}")
                n_error += 1
                continue
            for e in sorted(validator.iter_errors(rec), key=lambda e: e.path):
                loc = "/".join(str(x) for x in e.path) or "<root>"
                findings.append(f"  [error] records[{i}] ({rtype}) at {loc}: {e.message}")
                n_error += 1
            if args.check_hashes and isinstance(rec, dict) and "record_hash" in rec:
                expected = record_hash(rec)
                if rec["record_hash"] != expected:
                    findings.append(
                        f"  [error] records[{i}] ({rtype}): record_hash mismatch "
                        f"(stored {rec['record_hash']}, expected {expected})"
                    )
                    n_error += 1

        if findings:
            print(f"{bpath}:")
            print("\n".join(findings))

    print(f"\nChecked {len(bundle_paths)} bundle(s), {n_records} record(s): {n_error} error(s), {n_warn} warning(s).")
    if n_error or (args.warn_as_error and n_warn):
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
