#!/usr/bin/env python3
"""Regression (#264): the REAL proof-search bundle -> packet golden path.

Uses the actual `mathcorpus_export` bundle shape committed under
`schema/mcip/v1/fixtures/jacobian_dim3_real.bundle.json` — not a hand-tailored
fixture — to prove, end to end, that a real bundle:

1. folds into a freshly-stripped copy of its packet with ZERO errors,
2. reproduces the committed packet's child records (proof_variant, attempts,
   negatives, repair_trajectory, idea_attribution, dependency_manifest),
3. leaves zero referential-integrity findings (attempt/negative/repair refs
   resolve, the verified repair terminus is a proof variant, every repair
   step_hash recomputes, and idea_attributions resolve into the literature
   catalog and pin its record_hash),
4. is fully idempotent on a second fold.

Run: `python tools/test_mcip_golden_path.py` (exit non-zero on any failure).
"""

from __future__ import annotations

import copy
import json
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO / "tools"))

from mathcorpus import policy  # noqa: E402
from mathcorpus.mcip_import import fold_bundle_into_packet  # noqa: E402

BUNDLE = REPO / "schema/mcip/v1/fixtures/jacobian_dim3_real.bundle.json"
PACKET = REPO / "packets/frontier/jacobian/jacobian_conjecture_false_dim_three.v1.json"

# Everything the bundle folds onto the packet; stripped to simulate a fresh import.
_FOLDED_FIELDS = [
    "proof_variants", "attempts", "negative_examples",
    "repair_trajectories", "idea_attributions", "dependency_manifest",
]


def _errors(findings: list[policy.Finding]) -> list[str]:
    return [f"{f.code}: {f.message}" for f in findings if f.level == "error"]


def _ref_integrity_errors(packet: dict, literature_sources: dict) -> list[str]:
    findings: list[policy.Finding] = []
    findings += policy.check_attempts_and_repairs(packet)
    findings += policy.check_proof_variants(packet)
    findings += policy.check_literature_lineage(packet)
    findings += policy.check_literature_source_refs([packet], literature_sources)
    return _errors(findings)


def main() -> int:
    bundle = json.loads(BUNDLE.read_text(encoding="utf-8"))
    committed = json.loads(PACKET.read_text(encoding="utf-8"))

    # Fresh packet: keep identity + verification (incl. root_statement_sha256),
    # drop every record the bundle contributes.
    bare = copy.deepcopy(committed)
    for fld in _FOLDED_FIELDS:
        bare.pop(fld, None)

    # (1) First fold applies cleanly.
    r1 = fold_bundle_into_packet(bundle, bare)
    assert not r1.errors, f"first fold reported errors: {r1.errors}"
    assert r1.applied, "first fold applied nothing"
    # The literature_source is routed to the catalog (not onto the packet).
    lit = {r["record_id"]: r for r in r1.literature_sources}
    assert lit, "no literature_source routed to the catalog"

    # (2) The fold reproduces the committed packet's child records exactly.
    for fld in _FOLDED_FIELDS:
        assert bare.get(fld) == committed.get(fld), (
            f"folded '{fld}' differs from the committed packet"
        )

    # (3) Zero referential-integrity errors on the folded packet + catalog.
    ref_errs = _ref_integrity_errors(bare, lit)
    assert not ref_errs, "referential-integrity errors after fold:\n  " + "\n  ".join(ref_errs)

    # A verified repair trajectory must terminate at a proof-variant id.
    variant_ids = {v.get("variant_id") for v in bare.get("proof_variants") or []}
    for tr in bare.get("repair_trajectories") or []:
        if tr.get("terminal_outcome") == "verified_proof":
            assert tr.get("terminal_ref") in variant_ids, (
                f"verified repair terminal_ref {tr.get('terminal_ref')!r} is not a proof variant"
            )

    # Every folded id is colon-free (Windows/catalog safe).
    def _ids(pkt):
        for v in pkt.get("proof_variants") or []:
            yield v.get("variant_id")
        for a in pkt.get("attempts") or []:
            yield a.get("attempt_id")
        for n in pkt.get("negative_examples") or []:
            yield n.get("negative_id")
            yield n.get("attempt_id")
        for t in pkt.get("repair_trajectories") or []:
            yield t.get("terminal_ref")
            for s in t.get("steps") or []:
                yield s.get("from_attempt_id")
                yield s.get("to_ref")
        for ia in pkt.get("idea_attributions") or []:
            yield ia.get("attribution_id")
            yield ia.get("literature_source_id")
    for rid in _ids(bare):
        assert rid is None or ":" not in rid, f"id contains a colon: {rid!r}"

    # (4) Second fold is fully idempotent (nothing new applied, no errors).
    r2 = fold_bundle_into_packet(bundle, bare)
    assert not r2.errors, f"second fold reported errors: {r2.errors}"
    assert not r2.applied, f"second fold re-applied records (not idempotent): {r2.applied}"
    assert not r2.conflicts, f"second fold reported conflicts: {r2.conflicts}"

    print("golden path OK: real bundle folds with 0 errors, reproduces the committed "
          "packet, 0 referential-integrity errors, idempotent on re-fold.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
