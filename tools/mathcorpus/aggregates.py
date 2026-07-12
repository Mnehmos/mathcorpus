"""Corpus-wide summary aggregation, shared by tools/build_manifests.py and
tools/corpus_stats.py so the two reporting surfaces agree with each other.
"""

from __future__ import annotations

from collections import Counter, defaultdict
from typing import Any


def dependency_manifest_summary(packets: list[dict[str, Any]]) -> dict[str, Any]:
    """Frequency per dependency id per category, and transitive-depth distribution,
    across every packet that carries a dependency_manifest."""
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

    return {
        "packets_with_manifest": manifest_packet_count,
        "frequency_by_category": {cat: dict(counter.most_common()) for cat, counter in freq.items()},
        "transitive_depth": {
            "min": min(depths) if depths else None,
            "max": max(depths) if depths else None,
            "avg": (sum(depths) / len(depths)) if depths else None,
            "n": len(depths),
        },
    }


def proof_class_summary(packets: list[dict[str, Any]]) -> dict[str, Any]:
    """Distribution of proof_profile.primary_proof_class across every proof_variants[]
    entry in the corpus (a packet with N variants contributes up to N classes)."""
    primary = Counter()
    variant_count = 0
    for p in packets:
        for v in p.get("proof_variants") or []:
            variant_count += 1
            profile = v.get("proof_profile") or {}
            cls = profile.get("primary_proof_class")
            if cls:
                primary[cls] += 1
    return {
        "proof_variant_count": variant_count,
        "primary_proof_class": dict(primary.most_common()),
    }


def negative_counts(packets: list[dict[str, Any]]) -> dict[str, Any]:
    """Standalone negative-example packets vs. embedded attempts/negative_examples."""
    standalone = sum(1 for p in packets if p.get("kind") == "negative_example")
    embedded_negatives = sum(len(p.get("negative_examples") or []) for p in packets)
    attempts_total = sum(len(p.get("attempts") or []) for p in packets)
    attempts_failed = sum(
        1 for p in packets for a in (p.get("attempts") or []) if a.get("outcome") == "failed"
    )
    repair_trajectories = sum(len(p.get("repair_trajectories") or []) for p in packets)
    return {
        "standalone_negative_packets": standalone,
        "embedded_negative_examples": embedded_negatives,
        "embedded_attempts_total": attempts_total,
        "embedded_attempts_failed": attempts_failed,
        "repair_trajectories": repair_trajectories,
    }


def model_performance_summary(packets: list[dict[str, Any]]) -> dict[str, Any]:
    """Per-model-family episode count and episode-weighted mean eventual_pass_rate,
    across every model_runs[] entry in the corpus."""
    episodes: Counter = Counter()
    weighted_rate_sum: dict[str, float] = defaultdict(float)
    run_count = 0
    aggregate_count = 0
    for p in packets:
        for r in p.get("model_runs") or []:
            run_count += 1
            family = r.get("model_family") or "<unknown>"
            n = r.get("episode_count") or 0
            episodes[family] += n
            rate = r.get("eventual_pass_rate")
            if rate is not None and n:
                weighted_rate_sum[family] += rate * n
        aggregate_count += len(p.get("empirical_difficulty_aggregates") or [])

    by_family = {}
    for family, n in episodes.items():
        by_family[family] = {
            "episode_count": n,
            "eventual_pass_rate_weighted_mean": (weighted_rate_sum[family] / n) if n else None,
        }
    return {
        "model_run_count": run_count,
        "empirical_difficulty_aggregate_count": aggregate_count,
        "by_model_family": by_family,
    }
