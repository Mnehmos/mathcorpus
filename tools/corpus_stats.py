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

from mathcorpus import loader  # noqa: E402

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
    out.flush()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
