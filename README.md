# MathCorpus

**A verifier-gated, provenance-complete, curriculum-shaped mathematics corpus for training theorem-proving agents.**

MathCorpus is organized as a curriculum from elementary algebra to frontier-aligned
formal artifacts. Every accepted proof is **kernel-checked or certificate-checked**,
every item is **hash-pinned and attributed**, and every export is governed by explicit
**trust and redaction policy**.

> This is a *dataset product*, not a bag of Lean files. The unit of curation is a
> **concept packet** — a self-describing record bundling a formal artifact, its
> human-facing explanation, provenance, hashes, trust labels, redaction flags, and
> training eligibility.

Status: **pre-v0.1 scaffold.** The schema, tooling, governance, and CI gates are in
place; corpus authoring (Phases 2–7) is in progress. See [`docs/roadmap.md`](docs/roadmap.md).

---

## Core principles

1. **Proof authority comes only from checked artifacts.** The Lean kernel, verified
   LRAT replay, or kernel re-evaluation of imported witnesses may bear proof authority.
   Raw solver verdicts cannot. See the [trust ladder](REDACTION_POLICY.md#trust-ladder).
2. **Formula facts ≠ mathematical facts** unless joined by a proved encoding-soundness
   theorem. This is enforced structurally by the validator.
3. **Canonical objects, canonical hashes.** SHA-256 over canonical serializations binds
   packets, statements, proofs, CNFs, and manifests.
4. **Public training exports ≠ internal proof archives.** Tracked-benchmark and
   open-problem artifacts default to **quarantine** (fail-closed).
5. **Licensing and provenance are first-class data features.** No packet exports without
   a complete provenance, trust, redaction, hash, split, and toolchain record.

## Repository layout

```
schema/          JSON Schema for concept packets + enum reference
  mcip/v1/       MathCorpus Interchange Protocol — cross-repo evidence record schemas
packets/         The corpus — one JSON concept packet per item (curriculum tree)
restriction_profiles/  Shared, hash-pinned tactic/dependency restriction catalog
literature_sources/    Shared, hash-pinned literature-lineage catalog
lean/            Lean 4 project; formal proof bodies referenced by packets
tools/           Functional tooling: validate, hash, export, dedupe, redaction audit,
                 MCIP import, backfill reporting
manifests/       Generated corpus manifests (source, dedupe, split, license, artifacts,
                 dependency graph, backfill report)
exports/         Generated JSONL/Parquet exports (gitignored — regenerable)
governance/      REMOVALS.jsonl tombstones and governance state
hf/              Hugging Face dataset-card mirror
eval/            Evaluation-suite design, task families, leaderboard rules
docs/            Roadmap, proof-search integration, MCIP import/backfill, design notes
.github/         CI gates (schema validation, hash check, redaction audit)
```

## Governance & licensing

| Layer | License | File |
|-------|---------|------|
| Lean sources, tactics, formal proofs, tooling | Apache-2.0 | [`LICENSE`](LICENSE) |
| Prose, informal statements, proof ideas, cards | CC BY 4.0 | [`CONTENT_LICENSE`](CONTENT_LICENSE) |
| Internal / restricted proof artifacts | not distributed | [`REDACTION_POLICY.md`](REDACTION_POLICY.md) |

Governance files: [`DATASET_CARD.md`](DATASET_CARD.md) ·
[`EXPORT_POLICY.md`](EXPORT_POLICY.md) · [`REDACTION_POLICY.md`](REDACTION_POLICY.md) ·
[`TAKEDOWN_POLICY.md`](TAKEDOWN_POLICY.md) · [`ATTRIBUTION.md`](ATTRIBUTION.md) ·
[`CONTRIBUTING.md`](CONTRIBUTING.md)

## Quick start

```bash
# Validate every packet against the schema + policy rules (also validates the
# restriction_profiles/ and literature_sources/ catalogs, if present)
python tools/validate_packets.py packets/

# Recompute canonical hashes for a packet (or --check to verify without writing)
python tools/stamp_hashes.py packets/**/*.json
python tools/stamp_hashes.py --check packets/**/*.json

# Build public exports (applies redaction; fail-closed)
python tools/export_jsonl.py    packets/ --out exports/
python tools/build_split_manifest.py packets/ --out manifests/split_manifest.json
python tools/dedupe_pipeline.py packets/ --out manifests/dedupe_clusters.json
python tools/redaction_audit.py packets/ exports/

# MCIP: validate a bundle, import it into existing packets, check backfill coverage
python tools/validate_mcip.py   schema/mcip/v1/fixtures/ --check-hashes
python tools/import_mcip.py     <bundle_or_dir> --apply
python tools/backfill_report.py packets/ --out manifests/backfill_report.json
```

CI runs all of these on every PR touching `packets/`, `schema/`, or `tools/`.

## How the corpus is built: proof search

Formal artifacts enter MathCorpus through a **verifier-backed proof-search loop**, not
by pasting proofs. A candidate proof is only a candidate until the *pinned Lean kernel*
checks it inside a tracked episode; the ledger of attempts, diagnostics, and repairs is
preserved as training signal (including labeled negative examples). See
[`docs/proofsearch-integration.md`](docs/proofsearch-integration.md).

## Interchange, enrichment, and provenance (MCIP)

A packet's canonical identity (statement, proof, trust, training eligibility) is only
part of the picture. The **MathCorpus Interchange Protocol** (`schema/mcip/v1/`) is a
versioned, cross-repo evidence contract that lets richer proof-search output — proof
strategy, dependency evidence, failed attempts and repairs, multi-model performance, and
literature lineage — travel between MathCorpus and its proof-search environment without
either depending on the other's internal schema. Packets carry this as optional **child
evidence** (`proof_variants`, `dependency_manifest`, `attempts`/`negative_examples`/
`repair_trajectories`, `model_runs`/`empirical_difficulty_aggregates`,
`idea_attributions`/`prior_art_matches`/`citation_reviews`/`contribution_statements`,
`publication`) that never mutates canonical packet identity or proof authority — see
[`schema/ENUMS.md`](schema/ENUMS.md) for the full field reference. `tools/import_mcip.py`
folds an MCIP bundle into existing packets (idempotent, conflict-quarantining, dry-run by
default); see [`docs/mcip-import.md`](docs/mcip-import.md) for the full workflow,
including an honest accounting of what can and cannot be backfilled for packets authored
before this layer existed.

## Releases

- **v0.1** — frozen schema, validator in CI, trust/redaction enforced, ≥250 public
  packets, ≥25 negative examples, JSONL+Parquet exports, dataset cards, frozen
  train/val/test_public splits, live takedown policy.
- **v1.0** — undergrad + competition + public-safe frontier packets, certificate-backed
  finite claims with canonical CNF + certificate hashes, heldout eval program, baseline
  leaderboard, ≥99% provenance coverage.

See [`docs/roadmap.md`](docs/roadmap.md) for the full phase plan and quotas.
