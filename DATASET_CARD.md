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
and enumerated in [`schema/ENUMS.md`](schema/ENUMS.md). Key objects: `toolchain`,
`source_provenance`, `trust`, `training`, `certificate`, `encoding_soundness`, `hashes`,
`dependencies`, `metrics`, `artifacts`, `review`.

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
