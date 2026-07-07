#!/usr/bin/env python3
"""Three-level deduplication report.

1. Exact-file        — keyed by source_sha256 (byte-for-byte duplicates).
2. Canonical-theorem — keyed by formal_statement_sha256 + template_family_id.
3. Near-duplicate    — keyed by template_family_id / dedupe_cluster_id (family clusters).

Emits dedupe_clusters.json. Flags exact/canonical duplicates as warnings; family clusters
are informational (they are meant to stay together in one split).

Usage:
    python tools/dedupe_pipeline.py packets/ --out manifests/dedupe_clusters.json
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader  # noqa: E402


def _group(packets, keyfn):
    buckets: dict[str, list[str]] = defaultdict(list)
    for p in packets:
        key = keyfn(p)
        if key:
            buckets[key].append(p.get("packet_id"))
    return buckets


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--out", default="manifests/dedupe_clusters.json")
    args = ap.parse_args()

    packets = [lp.data for lp in loader.load_all(args.paths)]

    def source_key(p):
        return (p.get("hashes") or {}).get("source_sha256")

    def canonical_key(p):
        h = (p.get("hashes") or {}).get("formal_statement_sha256")
        fam = (p.get("training") or {}).get("template_family_id", "")
        return f"{h}|{fam}" if h else None

    def family_key(p):
        t = p.get("training") or {}
        return t.get("template_family_id") or t.get("dedupe_cluster_id")

    exact = {k: v for k, v in _group(packets, source_key).items() if len(v) > 1}
    canonical = {k: v for k, v in _group(packets, canonical_key).items() if len(v) > 1}
    families = {k: sorted(v) for k, v in _group(packets, family_key).items()}

    report = {
        "packet_count": len(packets),
        "exact_file_duplicates": {k: sorted(v) for k, v in exact.items()},
        "canonical_theorem_duplicates": {k: sorted(v) for k, v in canonical.items()},
        "family_clusters": dict(sorted(families.items())),
    }
    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    print(f"Wrote {out}.")
    print(f"  family clusters: {len(families)}")
    print(f"  exact-file duplicate groups: {len(exact)}")
    print(f"  canonical-theorem duplicate groups: {len(canonical)}")
    if exact or canonical:
        print("\nWARNING: byte-identical or statement-identical packets detected; "
              "confirm they belong to the same split family.", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
