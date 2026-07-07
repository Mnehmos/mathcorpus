# MathCorpus roadmap

Condensed from the design report *"MathCorpus Roadmap for a Verifier-Gated Mathematics
Training Corpus."* This is the phase plan, quotas, and release criteria the scaffold is
built to serve.

## Final prioritization (order that maximizes long-term value)

1. Schema and governance **before** scale.
2. Elementary bulk **before** frontier breadth.
3. Redaction and benchmark quarantine **before** public release.
4. Certificate metadata **before** a large frontier push.
5. Frozen evaluation **before** aggressive model-training claims.

## Phases & quotas

| Phase | Scope | Public packets | Frontier/private | Primary goal |
|-------|-------|----------------|------------------|--------------|
| 1 | Schema & governance | 0–25 | 0 | Validator, manifests, policy, tooling |
| 2 | Elementary spine | 150–250 | 0 | High-volume, low-risk curriculum base |
| 3 | Undergrad spine | 60–100 | 0–5 | Proof-rich, reusable mid-level corpus |
| 4 | Competition spine | 50–75 | 5–10 | Olympiad/Putnam-style formal proving |
| 5 | Frontier spine | 15–30 public-safe | 25–50 private | Open-problem companions, certificates |
| 6 | Export/tooling | all | all | JSONL/Parquet/HF release machinery |
| 7 | Evaluation suite | 100–200 eval | 25–50 heldout | Reproducible benchmarking |

**Phase 1 is the scaffold in this repo.** Everything below Phase 1 is authoring work.

## Elementary spine starter families (Phase 2)

Arithmetic identities (25) · divisibility & parity (20) · induction (20) · equations &
inequalities (25) · elementary functions (20) · finite combinatorics basics (20) ·
coordinate geometry basics (20) · angle basics (20). Over-index on **small, reusable
concepts** that generate many training tasks (formalization, synthesis, explanation,
next-tactic, repair).

## Kit families (assumed available / near-available)

`PowerSeriesKit`, `RecurrenceGeneratingFunctionKit`, `InequalityEstimateKit`,
`AffineAreaKit`, `GeometryAngleKit`, `FiniteConvexityKit`, `ExtremalCombinatoricsKit`,
`FiniteCertificateKit`, plus certificate trust-ladder machinery. Recorded per packet in
`dependencies.kits`.

## Release criteria

**v0.1** — schema frozen & documented · packet validator in CI · trust + redaction
taxonomy enforced automatically · ≥250 public packets · ≥25 negative examples · JSONL +
Parquet exports · HF + GitHub dataset cards · train/val/test_public frozen · no known
split-leakage · takedown policy live.

**v1.0** — 450–650 public packets (elementary + undergrad + competition + public-safe
frontier) · ≥25 tracked frontier packets with public/private separation ·
certificate-bearing packets carry canonical CNF + certificate hashes · heldout_public +
heldout_private eval running · baseline leaderboard · documented external-review process ·
provenance coverage >99% · reproducible end-to-end export.

## Risks (top mitigations)

- **Toolchain drift** → pin toolchain per release; keep source and semantic hashes separate.
- **Split leakage via templates** → family-level dedupe clusters; template-locked splits;
  release-time dedupe audit.
- **Missing encoding-soundness** → structural enforcement; `formula_fact_only` until a
  theorem binding exists.
- **License / benchmark contamination** → provenance gate; conservative import policy;
  default quarantine; proof-body redaction.
- **Overstating frontier results** → claim-class fields; external-review labels; release
  notes distinguish companion results from solved open problems.
