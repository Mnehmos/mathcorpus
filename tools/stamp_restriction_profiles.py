#!/usr/bin/env python3
"""Recompute and write record_hash for restriction-profile catalog files.

Restriction profiles (schema/mcip/v1/restriction_profile.schema.json) are hash-pinned and
reused across packets via proof_variants[].restriction_profile_id +
restriction_profile_sha256. This is the ``stamp_hashes.py`` equivalent for that catalog.

Usage:
    python tools/stamp_restriction_profiles.py restriction_profiles/
    python tools/stamp_restriction_profiles.py --check restriction_profiles/
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
        print("No restriction profile files found.", file=sys.stderr)
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
