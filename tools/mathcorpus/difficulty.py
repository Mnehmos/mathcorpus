"""Deterministic, versioned empirical-difficulty calibration.

Keeps author-assigned ``packet.difficulty_bin`` and empirically observed difficulty
strictly separate: this module only ever reads ``model_run`` records and produces a
score/bin pair for an ``empirical_difficulty_aggregate`` record. Nothing here writes to
``packet.difficulty_bin`` — no code path in this repo does.

A new formula gets a new ``CALIBRATION_VERSION`` rather than silently changing what an
existing stored ``observed_difficulty_score`` means; ``packet.schema.json`` currently
accepts only ``"v1"`` for ``empirical_difficulty_aggregate.calibration_version``.
"""

from __future__ import annotations

from typing import Any

CALIBRATION_VERSION = "v1"

# (max_score_inclusive, bin) — first match wins. Anything above the last threshold is D5.
_THRESHOLDS = [
    (0.05, "D0"),
    (0.20, "D1"),
    (0.40, "D2"),
    (0.65, "D3"),
    (0.90, "D4"),
]
_DEFAULT_BIN = "D5"


def observed_difficulty_score(model_runs: list[dict[str, Any]]) -> float:
    """1 minus the unweighted mean ``eventual_pass_rate`` across the given model runs.

    Runs without a recorded ``eventual_pass_rate`` are excluded — their absence is treated
    as missing data, not as a pass or a fail. Raises ``ValueError`` if none have a usable
    rate (an aggregate cannot be computed from zero evidence).
    """
    rates = [r["eventual_pass_rate"] for r in model_runs if r.get("eventual_pass_rate") is not None]
    if not rates:
        raise ValueError("no model_run in the given set has an eventual_pass_rate")
    return round(1.0 - (sum(rates) / len(rates)), 6)


def calibrated_bin(score: float) -> str:
    for max_score, bin_name in _THRESHOLDS:
        if score <= max_score:
            return bin_name
    return _DEFAULT_BIN


def compute(model_runs: list[dict[str, Any]]) -> tuple[float, str]:
    """Return ``(observed_difficulty_score, calibrated_difficulty_bin)`` for ``model_runs``."""
    score = observed_difficulty_score(model_runs)
    return score, calibrated_bin(score)
