#!/usr/bin/env python3
"""Export public packets to JSONL (canonical public row format).

Writes one combined ``packets.jsonl`` plus per-split files (``train.jsonl`` etc.).
Redaction is applied by mathcorpus.export (fail-closed). Non-public packets are skipped.

Usage:
    python tools/export_jsonl.py packets/ --out exports/
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import export, loader  # noqa: E402


def _write_jsonl(path: Path, rows: list[dict]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8", newline="\n") as fh:
        for row in rows:
            fh.write(json.dumps(row, ensure_ascii=False, sort_keys=True))
            fh.write("\n")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--out", default="exports", help="Output directory (default: exports/).")
    args = ap.parse_args()

    packets = [lp.data for lp in loader.load_all(args.paths)]
    rows = export.public_rows(packets)
    neg_rows = export.negative_rows(packets)

    out = Path(args.out)
    _write_jsonl(out / "packets.jsonl", rows)
    _write_jsonl(out / "negative_examples.jsonl", neg_rows)

    by_split: dict[str, list[dict]] = {}
    for row in rows:
        by_split.setdefault(row["split"], []).append(row)
    for split, split_rows in sorted(by_split.items()):
        _write_jsonl(out / f"{split}.jsonl", split_rows)

    counts = Counter(r["split"] for r in rows)
    skipped = len(packets) - len(rows) - len(neg_rows)
    print(f"Exported {len(rows)} public row(s) + {len(neg_rows)} negative example(s) "
          f"to {out}/ ({skipped} non-public skipped).")
    for split, n in sorted(counts.items()):
        print(f"  {split}: {n}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
