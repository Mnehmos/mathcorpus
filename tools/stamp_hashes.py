#!/usr/bin/env python3
"""Recompute and write canonical hashes into packet files.

Computes ``formal_statement_sha256`` (for formal items), ``proof_body_sha256`` (from
``proof_body_path`` when the file exists), and finally ``packet_sha256``. External-artifact
hashes (source/CNF/certificate) are preserved as authored — they are not derivable here.

Usage:
    python tools/stamp_hashes.py packets/**/*.json          # write in place
    python tools/stamp_hashes.py --check packets/           # verify, exit 1 if stale
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader  # noqa: E402
from mathcorpus.canonical import file_sha256  # noqa: E402
from mathcorpus.hashing import compute_hashes  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parent.parent


def _proof_body_hash(packet: dict) -> str | None:
    rel = packet.get("proof_body_path")
    if not rel:
        return None
    path = REPO_ROOT / rel
    if not path.exists():
        return None
    return file_sha256(path)


def _write_json(path: Path, data: dict) -> None:
    text = json.dumps(data, indent=2, ensure_ascii=False) + "\n"
    path.write_text(text, encoding="utf-8", newline="\n")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--check", action="store_true", help="Do not write; exit 1 if any hash is stale.")
    args = ap.parse_args()

    packets = loader.load_all(args.paths)
    if not packets:
        print("No packets found.", file=sys.stderr)
        return 1

    stale = 0
    changed = 0
    for lp in packets:
        pbh = _proof_body_hash(lp.data)
        new_hashes = compute_hashes(lp.data, proof_body_sha256=pbh)
        old_hashes = lp.data.get("hashes") or {}
        if new_hashes != old_hashes:
            if args.check:
                stale += 1
                print(f"STALE  {lp.path}")
            else:
                updated = dict(lp.data)
                updated["hashes"] = new_hashes
                _write_json(lp.path, updated)
                changed += 1
                print(f"stamped {lp.path}")
        else:
            if not args.check:
                print(f"ok      {lp.path}")

    if args.check:
        print(f"\n{len(packets)} checked, {stale} stale.")
        return 1 if stale else 0
    print(f"\n{len(packets)} processed, {changed} updated.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
