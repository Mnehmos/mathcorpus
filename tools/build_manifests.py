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

    # dependency_manifest aggregate: frequency per dependency id per category, and
    # transitive-depth distribution across packets that carry a manifest.
    freq: dict[str, Counter] = defaultdict(Counter)
    depths: list[int] = []
    manifest_packet_count = 0
    for p in packets:
        dm = p.get("dependency_manifest")
        if not dm:
            continue
        manifest_packet_count += 1
        for category, field in (
            ("declared", "declared_theorem_deps"), ("used", "used_theorem_deps"),
            ("obligation", "obligation_deps"), ("verified_module_item", "verified_module_item_deps"),
            ("retrieval_candidate", "retrieval_candidates"), ("retrieved_unused", "retrieved_unused_candidates"),
        ):
            for dep in dm.get(field) or []:
                freq[category][dep] += 1
        if dm.get("transitive_dependency_depth") is not None:
            depths.append(dm["transitive_dependency_depth"])

    dependency_manifest_summary = {
        "packets_with_manifest": manifest_packet_count,
        "frequency_by_category": {cat: dict(counter.most_common()) for cat, counter in freq.items()},
        "transitive_depth": {
            "min": min(depths) if depths else None,
            "max": max(depths) if depths else None,
            "avg": (sum(depths) / len(depths)) if depths else None,
            "n": len(depths),
        },
    }

    _write(out / "dependency_graph.json", {"nodes": [p.get("packet_id") for p in packets],
                                           "edges": dict(sorted(edges.items())),
                                           "dependency_manifest_summary": dependency_manifest_summary})

    print(f"Wrote corpus_index.json, license_manifest.json, SOURCE_MANIFEST.json, "
          f"dependency_graph.json to {out}/ ({len(packets)} packet(s)).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
