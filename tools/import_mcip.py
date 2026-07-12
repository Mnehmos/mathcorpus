#!/usr/bin/env python3
"""Import MCIP v1 bundle(s) into their target MathCorpus packets' child records.

Enriches existing packets (proof_variants, dependency_manifest, attempts,
negative_examples, repair_trajectories, model_runs, empirical_difficulty_aggregates) from
an MCIP bundle produced by Proof Search (or the conformance fixtures under
schema/mcip/v1/fixtures/). Never creates a new packet and never touches a packet's own
canonical identity fields (packet_id, title, theorem_name, formal_statement_pp, hashes,
trust, training, ...) — only its child records. restriction_profile records go to the
shared restriction_profiles/ catalog instead of into a packet.

Safety model:
  - A structurally invalid bundle is rejected outright (fail-closed), nothing is written.
  - A bundle whose packet_identity doesn't resolve to an existing packet, or whose
    formal_statement_sha256 disagrees with that packet's own, is quarantined whole.
  - Within an otherwise-valid bundle, each record that would conflict with an existing,
    differently-shaped entry is quarantined individually — everything else in the same
    bundle still applies. Conflicting evidence is never silently selected over what's
    already there.
  - Re-running the same bundle against the same packet state is a no-op (idempotent):
    already-applied records are recognized and skipped, not duplicated. This also makes a
    batch of many bundles resumable — a partial prior run can simply be re-run.
  - Default is dry-run: pass --apply to actually write packet files.

Usage:
    python tools/import_mcip.py schema/mcip/v1/fixtures/success_proof.bundle.json
    python tools/import_mcip.py schema/mcip/v1/fixtures/ --apply
    python tools/import_mcip.py bundles/ --apply --quarantine-report manifests/import_quarantine.json
"""

from __future__ import annotations

import argparse
import glob as _glob
import json
import sys
from pathlib import Path
from typing import Any

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import loader  # noqa: E402
from mathcorpus.hashing import compute_hashes  # noqa: E402
from mathcorpus.mcip import RECORD_TYPE_TO_SCHEMA_FILE, build_schema_registry, record_hash  # noqa: E402
from mathcorpus.mcip_import import fold_bundle_into_packet, import_restriction_profile  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parent.parent
PACKETS_DIR_DEFAULT = REPO_ROOT / "packets"
RESTRICTION_PROFILES_DIR_DEFAULT = REPO_ROOT / "restriction_profiles"
BUNDLE_SCHEMA_FILE = "bundle.schema.json"


def _iter_bundle_paths(arg: str) -> list[Path]:
    p = Path(arg)
    if p.is_dir():
        return sorted(p.glob("*.json"))
    if p.is_file():
        return [p]
    return [Path(m) for m in sorted(_glob.glob(arg, recursive=True))]


def _write_json(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")


def _validate_bundle_structurally(bundle: dict, schemas, registry, jsonschema_mod) -> list[str]:
    errors = []

    def _validator_for(schema):
        cls = jsonschema_mod.validators.validator_for(schema)
        return cls(schema, registry=registry)

    bundle_v = _validator_for(schemas[BUNDLE_SCHEMA_FILE])
    for e in bundle_v.iter_errors(bundle):
        loc = "/".join(str(x) for x in e.path) or "<root>"
        errors.append(f"bundle schema at {loc}: {e.message}")

    for i, rec in enumerate(bundle.get("records") or []):
        rtype = rec.get("record_type") if isinstance(rec, dict) else None
        fname = RECORD_TYPE_TO_SCHEMA_FILE.get(rtype)
        if fname is None:
            errors.append(f"records[{i}]: unknown or missing record_type {rtype!r}")
            continue
        rv = _validator_for(schemas[fname])
        for e in rv.iter_errors(rec):
            loc = "/".join(str(x) for x in e.path) or "<root>"
            errors.append(f"records[{i}] ({rtype}) at {loc}: {e.message}")
        if isinstance(rec, dict) and "record_hash" in rec and record_hash(rec) != rec["record_hash"]:
            errors.append(f"records[{i}] ({rtype}): record_hash does not match recompute")

    return errors


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("paths", nargs="+", help="Bundle files or a directory of bundle files.")
    ap.add_argument("--packets-dir", default=str(PACKETS_DIR_DEFAULT))
    ap.add_argument("--restriction-profiles-dir", default=str(RESTRICTION_PROFILES_DIR_DEFAULT))
    ap.add_argument("--apply", action="store_true", help="Write changes. Default is dry-run (report only).")
    ap.add_argument("--quarantine-report", default=None, help="Write a JSON report of quarantined records/bundles here.")
    args = ap.parse_args()

    import jsonschema as jsonschema_mod

    schemas, registry = build_schema_registry()

    all_packets = loader.load_all([args.packets_dir])
    packets_by_id = {lp.data.get("packet_id"): lp.path for lp in all_packets if lp.data.get("packet_id")}

    bundle_paths: list[Path] = []
    for arg in args.paths:
        bundle_paths.extend(_iter_bundle_paths(arg))
    bundle_paths = sorted(set(bundle_paths))
    if not bundle_paths:
        print("No bundle files found.", file=sys.stderr)
        return 1

    n_applied = n_skipped = n_conflicts = n_bundle_quarantined = n_packets_written = 0
    quarantine_report: list[dict[str, Any]] = []
    restriction_profiles_dir = Path(args.restriction_profiles_dir)

    for bpath in bundle_paths:
        try:
            bundle = json.loads(bpath.read_text(encoding="utf-8"))
        except json.JSONDecodeError as e:
            print(f"{bpath}: invalid JSON ({e}) — quarantined")
            quarantine_report.append({"bundle": str(bpath), "reason": f"invalid JSON: {e}"})
            n_bundle_quarantined += 1
            continue

        struct_errors = _validate_bundle_structurally(bundle, schemas, registry, jsonschema_mod)
        if struct_errors:
            print(f"{bpath}: structurally invalid — quarantined")
            for e in struct_errors:
                print(f"  {e}")
            quarantine_report.append({"bundle": str(bpath), "reason": "structurally invalid", "errors": struct_errors})
            n_bundle_quarantined += 1
            continue

        identity = next((r for r in bundle["records"] if r.get("record_type") == "packet_identity"), None)
        target_packet_id = identity.get("packet_id") if identity else None
        packet_path = packets_by_id.get(target_packet_id) if target_packet_id else None
        if packet_path is None:
            print(f"{bpath}: target packet '{target_packet_id}' not found in {args.packets_dir} — quarantined")
            quarantine_report.append({
                "bundle": str(bpath), "reason": "target packet not found", "packet_id": target_packet_id,
            })
            n_bundle_quarantined += 1
            continue

        packet = json.loads(packet_path.read_text(encoding="utf-8"))
        working = json.loads(json.dumps(packet))  # deep copy via round-trip
        result = fold_bundle_into_packet(bundle, working)

        if result.errors:
            print(f"{bpath}: rejected — quarantined")
            for e in result.errors:
                print(f"  {e}")
            quarantine_report.append({"bundle": str(bpath), "reason": "rejected", "errors": result.errors})
            n_bundle_quarantined += 1
            continue

        for field_name, rid in result.applied:
            print(f"{bpath}: + {field_name} {rid}" + ("" if args.apply else " (dry-run)"))
        for field_name, rid in result.skipped_idempotent:
            print(f"{bpath}: = {field_name} {rid} (already imported, no-op)")
        for field_name, rid, reason in result.conflicts:
            print(f"{bpath}: ! {field_name} {rid} CONFLICT: {reason} — quarantined")
            quarantine_report.append({
                "bundle": str(bpath), "packet_id": target_packet_id, "field": field_name,
                "record_id": rid, "reason": reason,
            })

        n_applied += len(result.applied)
        n_skipped += len(result.skipped_idempotent)
        n_conflicts += len(result.conflicts)

        if args.apply and result.applied:
            # compute_hashes recomputes formal_statement_sha256 (if formal) and
            # packet_sha256 last over the assembled packet; it preserves every other hash
            # (proof_body_sha256 etc.) as already authored, since child records never touch
            # the canonical proof body. The written file is already hash-consistent.
            working["hashes"] = compute_hashes(working)
            _write_json(packet_path, working)
            n_packets_written += 1

        for rp_record in result.restriction_profiles:
            rid = rp_record["record_id"]
            if not args.apply:
                print(f"{bpath}: + restriction_profile {rid} (dry-run)")
                continue
            status, rid = import_restriction_profile(rp_record, restriction_profiles_dir)
            if status == "applied":
                n_applied += 1
                print(f"{bpath}: + restriction_profile {rid}")
            elif status == "skipped_idempotent":
                n_skipped += 1
                print(f"{bpath}: = restriction_profile {rid} (already in catalog, no-op)")
            else:
                n_conflicts += 1
                print(f"{bpath}: ! restriction_profile {rid} CONFLICT with existing catalog entry — quarantined")
                quarantine_report.append({
                    "bundle": str(bpath), "field": "restriction_profiles", "record_id": rid,
                    "reason": "differs from existing catalog entry",
                })

    if args.quarantine_report:
        _write_json(Path(args.quarantine_report), {"quarantined": quarantine_report})

    mode = "applied" if args.apply else "dry-run — pass --apply to write"
    print(f"\n{len(bundle_paths)} bundle(s) processed ({mode}): "
          f"{n_applied} to apply, {n_skipped} already present, {n_conflicts} conflict(s), "
          f"{n_bundle_quarantined} whole-bundle quarantine(s).")
    if args.apply and n_packets_written:
        print(f"{n_packets_written} packet file(s) written (hashes recomputed in place). "
              "Now run: python tools/validate_packets.py packets/ --check-hashes")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
