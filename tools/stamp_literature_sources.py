#!/usr/bin/env python3
"""Recompute and write record_hash for literature-sources catalog files.

The shared literature_sources/ catalog holds LiteratureSource, RetrievedPassage, and
ExternalClaim records (schema/mcip/v1/{literature_source,retrieved_passage,external_claim}.schema.json)
— reusable, hash-pinned reference data, same pattern as restriction_profiles/. Packets
reference entries via IdeaAttribution.source_sha256_pin. This is the
stamp_restriction_profiles.py equivalent for that catalog.

Usage:
    python tools/stamp_literature_sources.py literature_sources/
    python tools/stamp_literature_sources.py --check literature_sources/
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader  # noqa: E402
from mathcorpus.mcip import record_hash  # noqa: E402


def _write_json(path: Path, data: dict) -> None:
    text = json.dumps(data, indent=2, ensure_ascii=False) + "\n"
    path.write_text(text, encoding="utf-8", newline="\n")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--check", action="store_true", help="Do not write; exit 1 if any hash is stale.")
    args = ap.parse_args()

    files = loader.load_all(args.paths)
    if not files:
        print("No literature-source files found.", file=sys.stderr)
        return 1

    stale = 0
    changed = 0
    for lf in files:
        expected = record_hash(lf.data)
        if lf.data.get("record_hash") != expected:
            if args.check:
                stale += 1
                print(f"STALE  {lf.path}")
            else:
                updated = dict(lf.data)
                updated["record_hash"] = expected
                _write_json(lf.path, updated)
                changed += 1
                print(f"stamped {lf.path}")
        elif not args.check:
            print(f"ok      {lf.path}")

    if args.check:
        print(f"\n{len(files)} checked, {stale} stale.")
        return 1 if stale else 0
    print(f"\n{len(files)} processed, {changed} updated.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
