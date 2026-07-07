#!/usr/bin/env python3
"""Build corpus manifests: corpus_index, license_manifest, source_manifest, dependency_graph.

These are derived views over the packet set, emitted for provenance and discoverability.
Run after validation. Splits/dedupe have their own dedicated tools.

Usage:
    python tools/build_manifests.py packets/ --out manifests/
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader  # noqa: E402


def _write(path: Path, obj) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--out", default="manifests")
    args = ap.parse_args()

    lps = loader.load_all(args.paths)
    packets = [lp.data for lp in lps]
    out = Path(args.out)

    # corpus_index.json
    index = [{
        "packet_id": p.get("packet_id"),
        "title": p.get("title"),
        "domain": p.get("domain"),
        "level": p.get("level"),
        "kind": p.get("kind"),
        "status": p.get("status"),
        "eligibility": (p.get("training") or {}).get("eligibility"),
        "packet_sha256": (p.get("hashes") or {}).get("packet_sha256"),
    } for p in packets]
    _write(out / "corpus_index.json", {
        "packet_count": len(packets),
        "by_domain": dict(Counter(p.get("domain") for p in packets)),
        "by_level": dict(Counter(p.get("level") for p in packets)),
        "by_kind": dict(Counter(p.get("kind") for p in packets)),
        "by_status": dict(Counter(p.get("status") for p in packets)),
        "packets": sorted(index, key=lambda e: e["packet_id"] or ""),
    })

    # license_manifest.json
    lic = [{
        "packet_id": p.get("packet_id"),
        "license_spdx": (p.get("source_provenance") or {}).get("license_spdx"),
        "license_content": (p.get("source_provenance") or {}).get("license_content"),
        "source_kind": (p.get("source_provenance") or {}).get("source_kind"),
    } for p in packets]
    _write(out / "license_manifest.json", {"entries": sorted(lic, key=lambda e: e["packet_id"] or "")})

    # SOURCE_MANIFEST.json
    src = [{
        "packet_id": p.get("packet_id"),
        "source_kind": (p.get("source_provenance") or {}).get("source_kind"),
        "source_refs": (p.get("source_provenance") or {}).get("source_refs", []),
        "authors": (p.get("source_provenance") or {}).get("authors", []),
        "statement_fidelity": (p.get("source_provenance") or {}).get("statement_fidelity"),
        "source_sha256": (p.get("hashes") or {}).get("source_sha256"),
    } for p in packets]
    _write(out / "SOURCE_MANIFEST.json", {"entries": sorted(src, key=lambda e: e["packet_id"] or "")})

    # dependency_graph.json (kits / theorem deps / prerequisite concepts)
    edges = defaultdict(list)
    for p in packets:
        deps = p.get("dependencies") or {}
        pid = p.get("packet_id")
        for kind in ("theorem_deps", "kits", "prerequisite_concepts"):
            for dep in deps.get(kind, []) or []:
                edges[pid].append({"to": dep, "type": kind})
    _write(out / "dependency_graph.json", {"nodes": [p.get("packet_id") for p in packets],
                                           "edges": dict(sorted(edges.items()))})

    print(f"Wrote corpus_index.json, license_manifest.json, SOURCE_MANIFEST.json, "
          f"dependency_graph.json to {out}/ ({len(packets)} packet(s)).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
