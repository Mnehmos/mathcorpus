#!/usr/bin/env python3
"""Backfill status report: what MCIP-shaped evidence exists per packet, what's missing.

Per issue #6's acceptance criteria: existing packets receive a backfill status report, and
fields that cannot be recovered are explicitly marked missing rather than silently absent.

This environment does not have access to Proof Search's retained trajectory
database/artifact store — only what's already in this repo (packet metadata, Lean source
files, and whatever tools/import_mcip.py has already folded in from a real MCIP bundle).
So most packets' attempts/diagnostics/model metadata are honestly reported
'unrecoverable_missing' here, not silently left blank. Re-run this after every
tools/import_mcip.py --apply batch to see the report improve.

Usage:
    python tools/backfill_report.py packets/ --out manifests/backfill_report.json
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parent.parent

# status values: 'recovered' (present and populated), 'not_yet_backfilled' (could exist,
# doesn't yet — worth importing more evidence for), 'unrecoverable_missing' (the source data
# needed to recover this no longer exists in any store this environment can reach),
# 'not_applicable' (this packet's kind/status means the field doesn't apply).


def _proof_shape_status(packet: dict) -> str:
    path = packet.get("proof_body_path")
    if not path:
        return "not_applicable"
    return "recovered" if (REPO_ROOT / path).exists() else "unrecoverable_missing"


def _proof_profile_status(packet: dict) -> str:
    for v in packet.get("proof_variants") or []:
        if v.get("proof_profile"):
            return "recovered"
    if packet.get("kind") == "negative_example":
        return "not_applicable"
    return "not_yet_backfilled"


def _dependency_evidence_status(packet: dict) -> str:
    if packet.get("dependency_manifest"):
        return "recovered"
    if packet.get("kind") == "negative_example":
        return "not_applicable"
    return "not_yet_backfilled"


def _episode_trajectory_status(packet: dict) -> str:
    verification = packet.get("verification") or {}
    episode_id = verification.get("episode_id")
    has_trajectory_hashes = bool(verification.get("trajectory_first_hash") or verification.get("trajectory_last_hash"))
    if episode_id and has_trajectory_hashes:
        return "recovered"
    if episode_id:
        return "partial_episode_id_only"
    return "unrecoverable_missing"


def _attempts_diagnostics_status(packet: dict) -> str:
    if packet.get("attempts"):
        return "recovered"
    return "unrecoverable_missing"  # no retained Proof Search trajectory DB in this environment


def _model_metadata_status(packet: dict) -> str:
    if packet.get("model_runs"):
        return "recovered"
    return "unrecoverable_missing"  # no retained Proof Search artifact store in this environment


def _proof_variants_repair_status(packet: dict) -> str:
    if packet.get("proof_variants") or packet.get("repair_trajectories"):
        return "recovered"
    return "not_yet_backfilled"  # reconstructable later via re-review; not lost forever


_FIELD_CHECKS = {
    "tactics_and_proof_shape": _proof_shape_status,
    "proof_profile": _proof_profile_status,
    "explicit_dependencies": _dependency_evidence_status,
    "episode_and_trajectory_linkage": _episode_trajectory_status,
    "attempts_and_diagnostics": _attempts_diagnostics_status,
    "model_hashes_tokens_cost_timing": _model_metadata_status,
    "proof_variants_and_repair_chains": _proof_variants_repair_status,
}


def packet_report(packet: dict) -> dict:
    return {
        "packet_id": packet.get("packet_id"),
        "kind": packet.get("kind"),
        "status": packet.get("status"),
        "fields": {name: check(packet) for name, check in _FIELD_CHECKS.items()},
    }


def build_report(packets: list[dict]) -> dict:
    per_packet = [packet_report(p) for p in packets]
    totals: dict[str, Counter] = {name: Counter() for name in _FIELD_CHECKS}
    for entry in per_packet:
        for field_name, status in entry["fields"].items():
            totals[field_name][status] += 1
    return {
        "packet_count": len(packets),
        "summary_by_field": {name: dict(counter) for name, counter in totals.items()},
        "packets": sorted(per_packet, key=lambda e: e["packet_id"] or ""),
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("paths", nargs="+")
    ap.add_argument("--out", default="manifests/backfill_report.json")
    args = ap.parse_args()

    packets = [lp.data for lp in loader.load_all(args.paths)]
    if not packets:
        print("No packets found.", file=sys.stderr)
        return 1

    report = build_report(packets)
    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")

    print(f"Backfill report for {report['packet_count']} packet(s) written to {out}.")
    for field_name, counts in report["summary_by_field"].items():
        print(f"  {field_name}: {counts}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
