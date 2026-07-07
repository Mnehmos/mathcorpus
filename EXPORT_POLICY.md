# Export Policy

Exports are produced only by the tooling in `tools/`, only from packets that pass
`validate_packets.py`, and only after license, trust, and redaction checks. Splits are
assigned **after** those checks, never before.

## Export-policy matrix

| Export surface | Public theorem source | Proof body | Certificate metadata | Certificate file | Private audit |
|----------------|-----------------------|------------|----------------------|------------------|---------------|
| Public JSONL train/val/test | yes if public | only if unredacted | yes | no | no |
| Public Parquet mirror | yes if public | only if unredacted | yes | no | no |
| Public dataset card / manifest | summary only | no | yes | no | no |
| Heldout-public leaderboard pack | statement only | no | maybe summary only | no | no |
| Heldout-private eval | statement hashes / restricted | no | internal only | internal only | internal only |
| Internal audit bundle | yes | yes | yes | yes | yes |

## Splits

Assigned only to `public_*` / `heldout_public` eligible packets, after all gates:

| Split | Target share of public-eligible pool | Purpose |
|-------|--------------------------------------|---------|
| `train` | 70–75% | Training and ablations |
| `val` | 10% | Prompt/model tuning |
| `test_public` | 10% | Reproducible public evaluation |
| `heldout_public` | 5–10% | Blind eval with hidden proofs/solutions |
| `quarantined` / `private_audit_only` | outside ratios | Benchmarks, tracked proofs, license-restricted, audits |

**Hard split rule (enforced by `build_split_manifest.py`):** if two packets share a
`template_family_id`, they must be assigned to the same top-level split family — unless
one is quarantined. This blocks leakage through near-duplicate templates.

## Deduplication (three levels)

1. **Exact-file** — keyed by `source_sha256`; removes byte-for-byte duplicates.
2. **Canonical-theorem** — keyed by `formal_statement_sha256` + `template_family_id`;
   prevents formatting-only variants crossing split boundaries.
3. **Near-duplicate family** — keyed by `template_family_id` / `dedupe_cluster_id` (and
   optionally MinHash/SimHash); keeps generated variants, equivalent identities, and
   paraphrases in the same split.

## Formats

- **JSONL** — canonical public row export (primary authoring/export format).
- **Parquet** — primary distribution mirror (columnar, Arrow-backed, HF-friendly).
- **Hugging Face dataset repo** — recommended public mirror; mirrors, does not replace,
  this repo's trust policy.
- **Private artifact store** — certificates, CNFs, audit bundles; never on public mirrors.

## Required manifests per release

`SOURCE_MANIFEST.json`, `DEDUPE_REPORT.json` / `dedupe_clusters.json`,
`split_manifest.json`, `license_manifest.json`, `artifact_manifest.json`,
`corpus_index.json`, `dependency_graph.json`, `dataset_infos.json`, `REMOVALS.jsonl`, and
a signed release tag or equivalent integrity record.
