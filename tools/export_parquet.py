#!/usr/bin/env python3
"""Export public packets to a Parquet mirror (primary distribution format).

Requires pyarrow (`pip install pyarrow`). Nested objects are stored as JSON strings so the
schema stays stable across packet-shape evolution. Degrades gracefully with a clear
message if pyarrow is absent.

Usage:
    python tools/export_parquet.py packets/ --out exports/packets.parquet
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import export, loader  # noqa: E402

# Columns kept as native scalars; everything else is serialized to a JSON string column.
_SCALAR_COLUMNS = [
    "packet_id", "packet_version", "title", "domain", "level", "kind", "status",
    "difficulty_bin", "lean_module", "theorem_name", "formal_statement_pp",
    "informal_statement", "proof_body_redacted", "split",
]


def _flatten(row: dict) -> dict:
    out = {c: row.get(c) for c in _SCALAR_COLUMNS}
    out["packet_json"] = json.dumps(row, ensure_ascii=False, sort_keys=True)
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--out", default="exports/packets.parquet")
    args = ap.parse_args()

    try:
        import pyarrow as pa
        import pyarrow.parquet as pq
    except ImportError:
        print("pyarrow not installed; skipping Parquet export "
              "(`pip install pyarrow`). JSONL export is unaffected.", file=sys.stderr)
        return 0

    packets = [lp.data for lp in loader.load_all(args.paths)]
    rows = [_flatten(r) for r in export.public_rows(packets)]
    if not rows:
        print("No public rows to export.")
        return 0

    columns = _SCALAR_COLUMNS + ["packet_json"]
    table = pa.table({c: [r.get(c) for r in rows] for c in columns})
    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    pq.write_table(table, out)
    print(f"Wrote {len(rows)} row(s) to {out}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
