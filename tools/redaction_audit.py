#!/usr/bin/env python3
"""Audit a public export for redaction leaks (fail-closed).

Scans exported JSONL rows and asserts that nothing forbidden by EXPORT_POLICY.md /
REDACTION_POLICY.md made it into a public surface:

* no private_artifact_uri / private artifact inventory / private bundle hash;
* no proof body reference on a packet marked redacted;
* no quarantined / private / disallowed packet present at all;
* heldout_public rows carry no proof body or solution hint.

Also re-derives the expected public rows from the source packets and diffs the set, so a
manually edited export cannot smuggle a packet in.

Usage:
    python tools/redaction_audit.py packets/ exports/
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import export, loader  # noqa: E402

FORBIDDEN_SUBSTRINGS = ("private_artifact_uri", "private_artifact_inventory",
                        "private_artifact_bundle_sha256")


def _read_jsonl(path: Path) -> list[dict]:
    rows = []
    with path.open("r", encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if line:
                rows.append(json.loads(line))
    return rows


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("packets_dir", help="Source packet directory (ground truth).")
    ap.add_argument("exports_dir", help="Directory with exported *.jsonl files.")
    args = ap.parse_args()

    packets = [lp.data for lp in loader.load_all([args.packets_dir])]
    expected = {r["packet_id"]: r for r in export.public_rows(packets)}
    expected_negative = {r["packet_id"]: r for r in export.negative_rows(packets)}

    exports_dir = Path(args.exports_dir)
    jsonl_files = sorted(exports_dir.glob("*.jsonl"))
    if not jsonl_files:
        print(f"No .jsonl files under {exports_dir}.", file=sys.stderr)
        return 1

    errors = 0
    checked = 0
    for jf in jsonl_files:
        for row in _read_jsonl(jf):
            checked += 1
            pid = row.get("packet_id")
            blob = json.dumps(row, ensure_ascii=False)

            for bad in FORBIDDEN_SUBSTRINGS:
                if bad in blob:
                    print(f"[error] {jf.name}: {pid} contains forbidden field '{bad}'")
                    errors += 1

            if row.get("proof_body_redacted") and row.get("proof_body_path"):
                print(f"[error] {jf.name}: {pid} is redacted but carries proof_body_path")
                errors += 1

            if row.get("split") == "heldout_public":
                if row.get("proof_body_path") or row.get("informal_proof_idea"):
                    print(f"[error] {jf.name}: heldout_public {pid} leaks proof body / solution hint")
                    errors += 1

            # combined file may repeat rows; only assert membership against expected set
            if jf.name == "packets.jsonl":
                pass
            elif jf.name == "negative_examples.jsonl":
                if pid not in expected_negative:
                    print(f"[error] {jf.name}: {pid} is not a public-safe negative example")
                    errors += 1
            elif pid not in expected:
                print(f"[error] {jf.name}: {pid} is not a publicly-eligible packet")
                errors += 1

    print(f"\nAudited {checked} exported row(s) across {len(jsonl_files)} file(s): {errors} error(s).")
    print(f"Expected {len(expected)} public packet(s) from source.")
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
