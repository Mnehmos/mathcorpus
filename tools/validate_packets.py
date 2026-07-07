#!/usr/bin/env python3
"""Validate MathCorpus packets against the JSON Schema and the policy rules.

Usage:
    python tools/validate_packets.py packets/
    python tools/validate_packets.py packets/**/*.json --check-hashes
    python tools/validate_packets.py packets/foo.v1.json --warn-as-error

Exit code 0 iff no errors (warnings alone do not fail unless --warn-as-error).
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader, policy  # noqa: E402

SCHEMA_PATH = Path(__file__).resolve().parent.parent / "schema" / "packet.schema.json"


def _load_schema_validator():
    try:
        import jsonschema
    except ImportError:
        print("ERROR: jsonschema not installed. `pip install -r tools/requirements.txt`", file=sys.stderr)
        raise SystemExit(2)
    schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
    cls = jsonschema.validators.validator_for(schema)
    cls.check_schema(schema)
    return cls(schema)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("paths", nargs="+", help="Packet files, directories, or globs.")
    ap.add_argument("--check-hashes", action="store_true", help="Also verify stored hashes match a recompute.")
    ap.add_argument("--warn-as-error", action="store_true", help="Treat warnings as errors.")
    args = ap.parse_args()

    validator = _load_schema_validator()
    packets = loader.load_all(args.paths)
    if not packets:
        print("No packets found.", file=sys.stderr)
        return 1

    n_error = 0
    n_warn = 0
    corpus_data = [lp.data for lp in packets]

    for lp in packets:
        rel = lp.path
        file_findings: list[str] = []

        # Structural: JSON Schema.
        for e in sorted(validator.iter_errors(lp.data), key=lambda e: e.path):
            loc = "/".join(str(x) for x in e.path) or "<root>"
            file_findings.append(f"  [error] schema at {loc}: {e.message}")
            n_error += 1

        # Cross-field: policy.
        findings = policy.check_packet(lp.data)
        if args.check_hashes:
            findings += policy.hash_mismatches(lp.data)
        for f in findings:
            file_findings.append(f"  {f}")
            if f.level == "error":
                n_error += 1
            else:
                n_warn += 1

        if file_findings:
            print(f"{rel}:")
            print("\n".join(file_findings))

    # Corpus-wide.
    corpus_findings = policy.check_corpus(corpus_data)
    if corpus_findings:
        print("<corpus>:")
        for f in corpus_findings:
            print(f"  {f}")
            if f.level == "error":
                n_error += 1
            else:
                n_warn += 1

    total = len(packets)
    print(f"\nChecked {total} packet(s): {n_error} error(s), {n_warn} warning(s).")
    if n_error or (args.warn_as_error and n_warn):
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
