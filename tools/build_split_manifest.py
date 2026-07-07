#!/usr/bin/env python3
"""Build split_manifest.json and enforce template-locked split invariants.

The manifest records, per packet, its eligibility and resolved split family, and asserts
the hard split rule: two packets sharing a template_family_id must share a split family
(unless one is quarantined). Exits non-zero on any leakage.

Usage:
    python tools/build_split_manifest.py packets/ --out manifests/split_manifest.json
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader, policy  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--out", default="manifests/split_manifest.json")
    args = ap.parse_args()

    packets = [lp.data for lp in loader.load_all(args.paths)]

    entries = []
    split_counts: dict[str, int] = defaultdict(int)
    for p in packets:
        training = p.get("training") or {}
        elig = training.get("eligibility")
        fam = policy._split_family(elig, training.get("split"))
        split_counts[fam] += 1
        entries.append({
            "packet_id": p.get("packet_id"),
            "eligibility": elig,
            "split_family": fam,
            "template_family_id": training.get("template_family_id"),
            "dedupe_cluster_id": training.get("dedupe_cluster_id"),
        })

    findings = [f for f in policy.check_corpus(packets) if f.code == "template_split_leak"]
    manifest = {
        "packet_count": len(packets),
        "split_family_counts": dict(sorted(split_counts.items())),
        "entries": sorted(entries, key=lambda e: e["packet_id"] or ""),
        "template_split_violations": [f.message for f in findings],
    }

    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    print(f"Wrote {out} ({len(packets)} packet(s)).")
    for fam, n in manifest["split_family_counts"].items():
        print(f"  {fam}: {n}")
    if findings:
        print("\nSPLIT LEAKAGE:", file=sys.stderr)
        for f in findings:
            print(f"  {f.message}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
