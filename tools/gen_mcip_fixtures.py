#!/usr/bin/env python3
"""Regenerate the MCIP v1 conformance fixtures under schema/mcip/v1/fixtures/.

Fixtures are generated, not hand-authored, so every ``record_hash`` is always current with
whatever the record's other fields say. Re-run after any change to a fixture's content:

    python tools/gen_mcip_fixtures.py

This does not depend on Proof Search or its SQLite schema — it only uses
``tools/mathcorpus`` (already used by the rest of the corpus tooling) to compute hashes the
same way ``tools/stamp_hashes.py`` does for packets.
"""

from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path
from typing import Any

sys.path.insert(0, str(Path(__file__).resolve().parent))

from mathcorpus import difficulty  # noqa: E402
from mathcorpus.mcip import record_hash  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parent.parent
FIXTURES_DIR = REPO_ROOT / "schema" / "mcip" / "v1" / "fixtures"

CREATED_AT = "2026-07-11T00:00:00Z"
ENV_HASH = "9e26d28efe88484c36562da27aa22a2cc73a0638d11532cbbc9071a60609025d"
PACKET_ID = "elementary.algebra.add_assoc.v1"
FORMAL_STATEMENT_SHA = "b90182e61b67b4c1f0c7706c0265f96a2db4ffd7cbf629202d37f4adb1f503f7"[:64]


def _fake_sha256(label: str) -> str:
    """Deterministic, fixture-only stand-in for a real artifact hash."""
    return hashlib.sha256(label.encode("utf-8")).hexdigest()


def _finalize(record: dict[str, Any]) -> dict[str, Any]:
    record = dict(record)
    record["record_hash"] = record_hash(record)
    return record


def _bundle(bundle_id: str, records: list[dict[str, Any]]) -> dict[str, Any]:
    return {
        "mcip_version": "1.0.0",
        "bundle_id": bundle_id,
        "created_at": CREATED_AT,
        "producer": "llm-driven-proof-search",
        "records": records,
    }


def _envelope(record_type: str, record_id: str, *, trust_status: str, export_eligibility: str) -> dict[str, Any]:
    return {
        "schema_version": "1.0.0",
        "record_type": record_type,
        "record_id": record_id,
        "packet_id": PACKET_ID,
        "environment_hash": ENV_HASH,
        "created_at": CREATED_AT,
        "trust_status": trust_status,
        "export_eligibility": export_eligibility,
    }


def success_proof_bundle() -> dict[str, Any]:
    identity = _finalize({
        **_envelope("packet_identity", "pi.add_assoc.1", trust_status="kernel_verified", export_eligibility="public"),
        "packet_version": "1.0.0",
        "formal_statement_sha256": FORMAL_STATEMENT_SHA,
        "lean_module": "MathCorpus.Elementary.Algebra.AddAssoc",
        "theorem_name": "add_assoc'",
        "toolchain": {"lean_version": "v4.32.0-rc1", "mathlib_rev": "360da6fa66c1273b76b6b2d8c5666fd5ac2e3b56"},
        "status": "kernel_verified",
    })
    variant = _finalize({
        **_envelope("proof_variant", "pv.add_assoc.canonical", trust_status="kernel_verified", export_eligibility="public"),
        "formal_statement_sha256": FORMAL_STATEMENT_SHA,
        "variant_style": "canonical",
        "proof_body_sha256": _fake_sha256("add_assoc canonical proof body"),
        "proof_body_redacted": False,
        "tactic_count": 1,
        "proof_length": 1,
        "restriction_profile_id": None,
        "restriction_profile_hash": None,
        "proof_profile_id": "pp.add_assoc.canonical",
        "model_run_id": None,
        "source": "proof_search",
    })
    profile = _finalize({
        **_envelope("proof_profile", "pp.add_assoc.canonical", trust_status="kernel_verified", export_eligibility="public"),
        "proof_variant_id": "pv.add_assoc.canonical",
        "primary_proof_class": "theorem_lookup",
        "secondary_proof_classes": [],
        "automation_level": "fully_automated",
        "retrieval_depth": 1,
        "planning_depth": 0,
        "branch_count": 0,
        "dependency_composition_depth": 1,
        "uses_witness_invention": False,
        "uses_induction": False,
        "uses_contradiction": False,
        "uses_case_analysis": False,
    })
    deps = _finalize({
        **_envelope("dependency_manifest", "dm.add_assoc", trust_status="kernel_verified", export_eligibility="public"),
        "proof_variant_id": "pv.add_assoc.canonical",
        "declared_theorem_deps": ["Mathlib.add_assoc"],
        "used_theorem_deps": ["Mathlib.add_assoc"],
        "obligation_deps": [],
        "verified_module_item_deps": ["Mathlib.add_assoc"],
        "transitive_dependency_count": 1,
        "transitive_dependency_depth": 1,
        "retrieval_candidates": ["Mathlib.add_assoc", "Mathlib.add_comm"],
        "retrieved_unused_candidates": ["Mathlib.add_comm"],
        "kits": ["core_algebra"],
        "tactic_tags": ["add_assoc"],
        "prerequisite_concepts": ["addition", "associativity"],
        "claim_sources": [
            {"dependency_id": "Mathlib.add_assoc", "category": "used", "source": "verifier_export"},
            {"dependency_id": "Mathlib.add_comm", "category": "retrieved_unused", "source": "proof_search_import"},
        ],
    })
    attempt = _finalize({
        **_envelope("attempt_record", "ar.add_assoc.1", trust_status="kernel_verified", export_eligibility="public"),
        "proof_variant_id": "pv.add_assoc.canonical",
        "episode_id": "d3dd664a-0cf1-4eb8-b538-4db8d6db4420",
        "outcome": "succeeded",
        "diagnostic_category": None,
        "diagnostics": [],
        "tokens": 412,
        "cost": 0.0031,
        "wall_time_ms": 890.0,
        "lean_cpu_time_ms": 210.0,
        "model_run_id": "mr.proofsearch.2026_07",
        "model_config_hash": _fake_sha256("proofsearch model config 2026-07"),
        "prompt_hash": _fake_sha256("add_assoc prompt"),
        "context_hash": _fake_sha256("add_assoc context"),
        "public_metadata": {"summary": "Closed by a single retrieved lemma."},
    })
    return _bundle("fixture.success_proof.v1", [identity, variant, profile, deps, attempt])


def failed_attempt_bundle() -> dict[str, Any]:
    identity = _finalize({
        **_envelope("packet_identity", "pi.failed_example.1", trust_status="candidate_unverified", export_eligibility="restricted"),
        "packet_version": "1.0.0",
        "formal_statement_sha256": None,
        "status": "failed_attempt",
    })
    attempt = _finalize({
        **_envelope("attempt_record", "ar.failed_example.1", trust_status="tracked_episode", export_eligibility="restricted"),
        "proof_variant_id": None,
        "episode_id": "8b1c9e2a-1111-4a11-9a11-111111111111",
        "outcome": "failed",
        "diagnostic_category": "unsolved_goals",
        "diagnostics": [
            {
                "category": "unsolved_goals",
                "message": "unsolved goals",
                "source_span": "line 4, col 2",
                "goals": ["⊢ a + b = b + a"],
                "local_context": ["a b : ℤ"],
                "unsolved_goals": ["⊢ a + b = b + a"],
            }
        ],
        "tokens": 220,
        "cost": 0.0016,
        "wall_time_ms": 430.0,
        "lean_cpu_time_ms": 95.0,
        "model_run_id": "mr.proofsearch.2026_07",
        "model_config_hash": _fake_sha256("proofsearch model config 2026-07"),
        "prompt_hash": _fake_sha256("failed_example prompt"),
        "context_hash": _fake_sha256("failed_example context"),
        "public_metadata": {"summary": "Tried `rfl`, did not close the commutativity goal."},
    })
    negative = _finalize({
        **_envelope("negative_example", "ne.failed_example.1", trust_status="tracked_episode", export_eligibility="restricted"),
        "attempt_id": "ar.failed_example.1",
        "origin": "organic",
        "diagnostic_category": "unsolved_goals",
        "candidate_source_ref": "proofsearch://trajectories/8b1c9e2a-1111-4a11-9a11-111111111111",
        "proof_authority": "none",
        "can_export_metadata": True,
        "can_export_proof_text": False,
        "can_export_diagnostics": True,
        "can_export_model_identity": False,
    })
    return _bundle("fixture.failed_attempt.v1", [identity, attempt, negative])


def repair_chain_bundle() -> dict[str, Any]:
    identity = _finalize({
        **_envelope("packet_identity", "pi.repair_example.1", trust_status="kernel_verified", export_eligibility="public"),
        "packet_version": "1.0.0",
        "formal_statement_sha256": FORMAL_STATEMENT_SHA,
        "status": "kernel_verified",
    })
    failed = _finalize({
        **_envelope("attempt_record", "ar.repair_example.failed", trust_status="tracked_episode", export_eligibility="restricted"),
        "proof_variant_id": None,
        "episode_id": "cafe1234-2222-4b22-9b22-222222222222",
        "outcome": "failed",
        "diagnostic_category": "unsolved_goals",
        "diagnostics": [
            {
                "category": "unsolved_goals",
                "message": "unsolved goals",
                "source_span": "line 2, col 2",
                "goals": ["⊢ a + b + c = a + (b + c)"],
                "local_context": ["a b c : ℤ"],
                "unsolved_goals": ["⊢ a + b + c = a + (b + c)"],
            }
        ],
        "tokens": 150,
        "cost": 0.0011,
        "wall_time_ms": 300.0,
        "lean_cpu_time_ms": 60.0,
        "model_run_id": "mr.proofsearch.2026_07",
        "model_config_hash": _fake_sha256("proofsearch model config 2026-07"),
        "prompt_hash": _fake_sha256("repair_example prompt attempt 1"),
        "context_hash": _fake_sha256("repair_example context attempt 1"),
        "public_metadata": {"summary": "First attempt closed the wrong associativity direction."},
    })
    repaired_variant = _finalize({
        **_envelope("proof_variant", "pv.repair_example.canonical", trust_status="kernel_verified", export_eligibility="public"),
        "formal_statement_sha256": FORMAL_STATEMENT_SHA,
        "variant_style": "canonical",
        "proof_body_sha256": _fake_sha256("repair_example repaired proof body"),
        "proof_body_redacted": False,
        "tactic_count": 1,
        "proof_length": 1,
        "restriction_profile_id": None,
        "restriction_profile_hash": None,
        "proof_profile_id": None,
        "model_run_id": "mr.proofsearch.2026_07",
        "source": "proof_search",
    })
    repaired = _finalize({
        **_envelope("attempt_record", "ar.repair_example.succeeded", trust_status="kernel_verified", export_eligibility="public"),
        "proof_variant_id": "pv.repair_example.canonical",
        "episode_id": "cafe1234-2222-4b22-9b22-222222222222",
        "outcome": "succeeded",
        "diagnostic_category": None,
        "diagnostics": [],
        "tokens": 180,
        "cost": 0.0013,
        "wall_time_ms": 340.0,
        "lean_cpu_time_ms": 70.0,
        "model_run_id": "mr.proofsearch.2026_07",
        "model_config_hash": _fake_sha256("proofsearch model config 2026-07"),
        "prompt_hash": _fake_sha256("repair_example prompt attempt 2"),
        "context_hash": _fake_sha256("repair_example context attempt 2"),
        "public_metadata": {"summary": "Repaired by swapping to `add_assoc` directly."},
    })
    trajectory = _finalize({
        **_envelope("repair_trajectory", "rt.repair_example.1", trust_status="kernel_verified", export_eligibility="public"),
        "steps": [
            {
                "step_index": 0,
                "from_attempt_id": "ar.repair_example.failed",
                "repair_action": "swap `add_comm` for `add_assoc` to match the goal direction",
                "diagnostic_category_addressed": "unsolved_goals",
                "to_ref": "ar.repair_example.succeeded",
                "step_hash": _fake_sha256("repair_example step 0"),
            }
        ],
        "terminal_outcome": "verified_proof",
        "terminal_ref": "pv.repair_example.canonical",
    })
    return _bundle("fixture.repair_chain.v1", [identity, failed, repaired_variant, repaired, trajectory])


def multi_model_aggregate_bundle() -> dict[str, Any]:
    identity = _finalize({
        **_envelope("packet_identity", "pi.multi_model.1", trust_status="kernel_verified", export_eligibility="public"),
        "packet_version": "1.0.0",
        "formal_statement_sha256": FORMAL_STATEMENT_SHA,
        "status": "kernel_verified",
    })
    run_a = _finalize({
        **_envelope("model_run", "mr.multi_model.model_a", trust_status="tracked_episode", export_eligibility="restricted"),
        "evaluation_suite_version": "eval-suite-2026.07",
        "policy_version": "policy-2026.07",
        "model_family": "model-a-family",
        "model_version": "model-a-2026-06",
        "model_config_hash": _fake_sha256("model-a config"),
        "episode_count": 8,
        "seeds": [1, 2, 3, 4, 5, 6, 7, 8],
        "first_attempt_pass_rate": 0.375,
        "eventual_pass_rate": 0.75,
        "attempts_to_pass_distribution": {"1": 3, "2": 2, "3+": 1},
        "tokens": 18400,
        "cost": 0.42,
        "wall_time_ms": 96000.0,
        "lean_cpu_time_ms": 5200.0,
        "failure_category_distribution": {"unsolved_goals": 2},
        "public_metadata": {"model_family": "model-a-family"},
    })
    run_b = _finalize({
        **_envelope("model_run", "mr.multi_model.model_b", trust_status="tracked_episode", export_eligibility="restricted"),
        "evaluation_suite_version": "eval-suite-2026.07",
        "policy_version": "policy-2026.07",
        "model_family": "model-b-family",
        "model_version": "model-b-2026-06",
        "model_config_hash": _fake_sha256("model-b config"),
        "episode_count": 8,
        "seeds": [1, 2, 3, 4, 5, 6, 7, 8],
        "first_attempt_pass_rate": 0.625,
        "eventual_pass_rate": 1.0,
        "attempts_to_pass_distribution": {"1": 5, "2": 3},
        "tokens": 15100,
        "cost": 0.38,
        "wall_time_ms": 81000.0,
        "lean_cpu_time_ms": 4700.0,
        "failure_category_distribution": {},
        "public_metadata": {"model_family": "model-b-family"},
    })
    _score, _bin = difficulty.compute([{"eventual_pass_rate": 0.75}, {"eventual_pass_rate": 1.0}])
    aggregate = _finalize({
        **_envelope("empirical_difficulty_aggregate", "eda.multi_model.1", trust_status="tracked_episode", export_eligibility="restricted"),
        "model_run_ids": ["mr.multi_model.model_a", "mr.multi_model.model_b"],
        "calibration_version": difficulty.CALIBRATION_VERSION,
        "observed_difficulty_score": _score,
        "calibrated_difficulty_bin": _bin,
        "author_difficulty_bin": "D0",
        "evaluation_suite_version": "eval-suite-2026.07",
        "policy_version": "policy-2026.07",
        "model_config_hash": None,
        "public_metadata": {"note": "Two-model aggregate; author bin unchanged pending review."},
    })
    return _bundle("fixture.multi_model_aggregate.v1", [identity, run_a, run_b, aggregate])


def main() -> int:
    FIXTURES_DIR.mkdir(parents=True, exist_ok=True)
    bundles = {
        "success_proof.bundle.json": success_proof_bundle(),
        "failed_attempt.bundle.json": failed_attempt_bundle(),
        "repair_chain.bundle.json": repair_chain_bundle(),
        "multi_model_aggregate.bundle.json": multi_model_aggregate_bundle(),
    }
    for name, bundle in bundles.items():
        path = FIXTURES_DIR / name
        path.write_text(json.dumps(bundle, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")
        print(f"wrote {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
