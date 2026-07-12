# Dataset Card: MathCorpus

## Dataset summary

MathCorpus is a verifier-gated, provenance-complete, curriculum-shaped mathematics corpus
for training theorem-proving agents. It spans elementary algebra through frontier-aligned
formal artifacts. Every accepted proof is kernel-checked or certificate-checked; every
item is hash-pinned and attributed; every export is governed by explicit trust and
redaction policy.

The unit of curation is a **concept packet** (see [`schema/`](schema/)): a self-describing
record bundling a formal artifact, informal explanation, provenance, hashes, trust labels,
redaction flags, and training eligibility.

## Supported tasks

Informal→formal statement, formal-proof synthesis, next-tactic prediction, proof repair,
proof explanation, dependency retrieval, certificate reconstruction, and negative-example
discrimination. See [`eval/README.md`](eval/README.md) for task definitions and metrics.

## Languages / formalism

Natural-language mathematics (English) paired with **Lean 4 + mathlib** formal artifacts,
under a pinned toolchain recorded per packet.

## Data fields

Top-level packet fields are defined by [`schema/packet.schema.json`](schema/packet.schema.json)
and enumerated in [`schema/ENUMS.md`](schema/ENUMS.md).

**Canonical fields** (identity, never mutated by enrichment): `toolchain`,
`source_provenance`, `trust`, `training`, `certificate`, `encoding_soundness`, `hashes`,
`dependencies`, `metrics`, `artifacts`, `review`.

**Optional child evidence** (MathCorpus Interchange Protocol — see
[`schema/mcip/v1/README.md`](schema/mcip/v1/README.md)), additive and never affecting
proof authority or trust:

| Field | Evidence |
|---|---|
| `proof_variants[]` | Additional proofs of the same statement (shortest, pedagogical, restricted, interactive, alternate-model), each with a `proof_profile` (proof-strategy classification) |
| `dependency_manifest` | Declared vs. retrieved vs. actually-used theorem dependencies, with per-claim provenance |
| `attempts[]`, `negative_examples[]`, `repair_trajectories[]` | Tracked proof-search attempts (including failures and diagnostics) and hash-linked repair chains |
| `model_runs[]`, `empirical_difficulty_aggregates[]` | Multi-model evaluation evidence and a reproducibly-computed observed-difficulty score, kept separate from the author-assigned `difficulty_bin` |
| `idea_attributions[]`, `prior_art_matches[]`, `citation_reviews[]`, `contribution_statements[]` | Literature lineage — which sources influenced (or didn't) a proof, distinct model-visible vs. post-hoc discovery, and an explicit contribution-class declaration |
| `publication` | Publication-readiness status, gated separately from kernel verification (see below) |

## Publication readiness

A kernel-verified packet is not automatically publication-ready. `publication.status`
(`metadata_only` … `publication_ready` / `blocked_missing_attribution` /
`blocked_novelty_claim`) is a separate review dimension: kernel verification alone can
never produce `publication_ready`, and a `contribution_class: "new_proof"` declaration is
blocked from it without a current, endorsed citation review. Citation or novelty
uncertainty changes only this public claim status, never proof truth. Every export row
carries both a machine-readable form (`contribution_statements`/`publication`) and a
human-readable `contribution_summary` sentence.

## Data splits

`train`, `val`, `test_public`, `heldout_public`, `heldout_private`, `quarantined`,
`private_audit_only`. Splits are assigned after license/trust/redaction checks and are
template-locked to prevent leakage. See [`EXPORT_POLICY.md`](EXPORT_POLICY.md).

## Curation rationale

Optimize for **curation density**, not raw theorem count: small, reusable elementary
concepts that generate many training tasks, plus canonical undergrad/competition theorem
packets and a conservative frontier layer with public/private separation.

## Considerations for responsible use

- **Contamination:** tracked-benchmark and open-problem artifacts default to quarantine;
  proof bodies are redacted from public export (fail-closed).
- **Trust:** proof authority derives only from checked artifacts (Lean kernel / verified
  LRAT replay / kernel-rechecked witness). Certificate "formula facts" are separated from
  "mathematical facts" unless a proved encoding-soundness lemma links them.
- **Licensing:** Apache-2.0 (code/formal) + CC BY 4.0 (prose); per-item provenance in
  `source_provenance`. See [`ATTRIBUTION.md`](ATTRIBUTION.md).
- **Removals:** see [`TAKEDOWN_POLICY.md`](TAKEDOWN_POLICY.md); tombstones in
  [`governance/REMOVALS.jsonl`](governance/REMOVALS.jsonl).

## Provenance & integrity

Every packet carries SHA-256 hashes over canonical serializations (`packet_sha256`,
`formal_statement_sha256`, `source_sha256`, `proof_body_sha256`, and — for
certificate-backed items — `canonical_cnf_sha256`, `certificate_sha256`). Toolchain and
mathlib revisions are pinned per packet.

## Licensing

See [`LICENSE`](LICENSE) (Apache-2.0) and [`CONTENT_LICENSE`](CONTENT_LICENSE) (CC BY 4.0).

## Citation

```bibtex
@misc{mathcorpus,
  title  = {MathCorpus: A Verifier-Gated Mathematics Training Corpus},
  author = {The MathCorpus Authors},
  year   = {2026},
  note   = {https://github.com/Mnehmos/mathcorpus}
}
```
