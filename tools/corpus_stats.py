#!/usr/bin/env python3
"""Print corpus statistics (UTF-8 safe, portable across OS locales).

Reads the packet set directly (not a manifest) so it always reflects the working
tree. Explicit UTF-8 I/O avoids the Windows cp1252 default choking on math glyphs.

Usage:
    python tools/corpus_stats.py            # human summary
    python tools/corpus_stats.py --json     # machine-readable
"""

from __future__ import annotations

import argparse
import io
import json
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import aggregates, loader  # noqa: E402

REPO = Path(__file__).resolve().parent.parent


def collect() -> dict:
    packets = [lp.data for lp in loader.load_all([str(REPO / "packets")])]
    verified = [p for p in packets if p.get("status") in ("kernel_verified", "verified_certificate")]
    negative = [p for p in packets if p.get("kind") == "negative_example"]
    v0_1_target = 250
    return {
        "packet_files": len(packets),
        "verified_public": len(verified),
        "negative_examples": len(negative),
        "by_domain": dict(sorted(Counter(p.get("domain") for p in packets).items())),
        "by_level": dict(sorted(Counter(p.get("level") for p in packets).items())),
        "by_kind": dict(sorted(Counter(p.get("kind") for p in packets).items())),
        "by_status": dict(sorted(Counter(p.get("status") for p in packets).items())),
        "v0_1_public_target": v0_1_target,
        "v0_1_pct": round(100 * len(verified) / v0_1_target, 1),
        "v0_1_remaining": max(0, v0_1_target - len(verified)),
        "proof_classes": aggregates.proof_class_summary(packets),
        "dependency_manifest": aggregates.dependency_manifest_summary(packets),
        "negative_counts": aggregates.negative_counts(packets),
        "model_performance": aggregates.model_performance_summary(packets),
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()

    out = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", newline="\n")
    stats = collect()
    if args.json:
        out.write(json.dumps(stats, ensure_ascii=False, indent=2) + "\n")
        out.flush()
        return 0

    out.write(f"MathCorpus: {stats['verified_public']} verified public "
              f"+ {stats['negative_examples']} negative ({stats['packet_files']} files)\n")
    out.write(f"  v0.1: {stats['v0_1_pct']}% of {stats['v0_1_public_target']} "
              f"({stats['v0_1_remaining']} to go)\n")
    out.write(f"  by domain: {stats['by_domain']}\n")
    out.write(f"  by level:  {stats['by_level']}\n")
    out.write(f"  proof classes: {stats['proof_classes']['primary_proof_class']} "
              f"({stats['proof_classes']['proof_variant_count']} variant(s))\n")
    dm = stats['dependency_manifest']
    out.write(f"  dependency depth: min={dm['transitive_depth']['min']} "
              f"max={dm['transitive_depth']['max']} avg={dm['transitive_depth']['avg']} "
              f"({dm['packets_with_manifest']} packet(s) with a manifest)\n")
    nc = stats['negative_counts']
    out.write(f"  negatives: {nc['standalone_negative_packets']} standalone packet(s), "
              f"{nc['embedded_negative_examples']} embedded, "
              f"{nc['repair_trajectories']} repair trajector(y/ies)\n")
    mp = stats['model_performance']
    out.write(f"  model performance: {mp['model_run_count']} run(s), "
              f"{mp['empirical_difficulty_aggregate_count']} aggregate(s), "
              f"by family: {mp['by_model_family']}\n")
    out.flush()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
