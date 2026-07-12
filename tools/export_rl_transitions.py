#!/usr/bin/env python3
"""Validate, join, and export RL transition bundles (schema/mcip/v1/rl_transition.schema.json)
to a canonical rl_transitions.jsonl + episode_manifest.json.

This is the MathCorpus-side half of issue #9. It never treats packets.jsonl / packet-shaped
records as RL transitions: the input here is rl_transition MCIP bundles, produced upstream by
llm-driven-proof-search's exporter (llm-driven-proof-search#238) once that ships — see
docs/rl-transitions.md for current cross-repo status. Until then this tool has no real input
to run against; schema/mcip/v1/fixtures/rl_episode.bundle.json is a synthetic conformance
fixture used to prove the pipeline itself works end to end, not real trajectory data.

A transition only reaches the public export if BOTH its own export_eligibility=='public' AND
the packet it is about has public/heldout-public training.eligibility — a packet's own
restriction is always authoritative over what an individual transition record claims (see
tools/mathcorpus/rl_transitions.is_publicly_exportable).

Usage:
    python tools/export_rl_transitions.py schema/mcip/v1/fixtures/rl_episode.bundle.json --out exports/
    python tools/export_rl_transitions.py rl_transitions/ --out exports/
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader  # noqa: E402
from mathcorpus.rl_transitions import (  # noqa: E402
    build_episode_manifest,
    check_episode_contiguity,
    check_transition_record,
    is_publicly_exportable,
    iter_bundle_paths,
    join_transition_to_packet,
    load_transitions_from_bundles,
)

REPO_ROOT = Path(__file__).resolve().parent.parent
PACKETS_DIR_DEFAULT = REPO_ROOT / "packets"


def _write_jsonl(path: Path, rows: list[dict]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8", newline="\n") as fh:
        for row in rows:
            fh.write(json.dumps(row, ensure_ascii=False, sort_keys=True))
            fh.write("\n")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("paths", nargs="+", help="Bundle files, or a directory of bundle files.")
    ap.add_argument("--packets-dir", default=str(PACKETS_DIR_DEFAULT))
    ap.add_argument("--out", default="exports", help="Output directory (default: exports/).")
    args = ap.parse_args()

    bundle_paths: list[Path] = []
    for arg in args.paths:
        bundle_paths.extend(iter_bundle_paths(arg))
    bundle_paths = sorted(set(bundle_paths))
    if not bundle_paths:
        print("No bundle files found.", file=sys.stderr)
        return 1

    load_result = load_transitions_from_bundles(bundle_paths)
    for e in load_result.structural_errors:
        print(f"STRUCTURAL: {e}")

    packets_by_id = {
        lp.data["packet_id"]: lp.data for lp in loader.load_all([args.packets_dir]) if lp.data.get("packet_id")
    }

    joined: list[dict] = []
    n_join_failed = 0
    n_business_errors = 0
    n_business_warnings = 0
    for t in load_result.transitions:
        packet, err = join_transition_to_packet(t, packets_by_id)
        if err:
            print(f"JOIN FAILED: {t.get('record_id', '<unknown>')}: {err}")
            n_join_failed += 1
            continue
        for finding in check_transition_record(t):
            print(str(finding))
            if finding.level == "error":
                n_business_errors += 1
            else:
                n_business_warnings += 1
        joined.append({"transition": t, "packet": packet})

    for finding in check_episode_contiguity(load_result.transitions):
        print(str(finding))
        n_business_errors += 1

    public_transitions = [
        j["transition"] for j in joined
        if is_publicly_exportable(j["transition"], j["packet"])
    ]

    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    for stale in ("rl_transitions.jsonl", "rl_episode_manifest.json"):
        stale_path = out / stale
        if stale_path.exists():
            stale_path.unlink()
    _write_jsonl(out / "rl_transitions.jsonl", public_transitions)
    manifest = build_episode_manifest(public_transitions)
    (out / "rl_episode_manifest.json").write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False, sort_keys=True) + "\n", encoding="utf-8", newline="\n"
    )

    print(
        f"\n{len(bundle_paths)} bundle(s), {len(load_result.transitions)} rl_transition record(s) "
        f"loaded ({len(load_result.structural_errors)} structural error(s)), "
        f"{n_join_failed} join failure(s), {n_business_errors} business-rule error(s), "
        f"{n_business_warnings} warning(s)."
    )
    print(
        f"Exported {len(public_transitions)} publicly-eligible transition(s) across "
        f"{len(manifest)} episode(s) to {out}/rl_transitions.jsonl + rl_episode_manifest.json."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
