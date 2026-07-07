# Packet enum reference

Authoritative enums live in [`packet.schema.json`](packet.schema.json); this is the
human-readable companion. Cross-field *policy* rules are in
[`../tools/mathcorpus/policy.py`](../tools/mathcorpus/policy.py).

## `domain`
`arithmetic`, `algebra`, `number_theory`, `combinatorics`, `analysis`, `real_analysis`,
`geometry`, `topology`, `logic`, `linear_algebra`, `abstract_algebra`, `set_theory`,
`probability`, `frontier`

## `level`
`L0_elementary`, `L1_proof_basics`, `L2_olympiad`, `L3_undergrad`,
`L4_advanced_undergrad`, `L5_grad`, `L6_known_theorem`, `L7_frontier`

## `kind`
`concept`, `theorem`, `exercise`, `certificate_claim`, `negative_example`,
`benchmark_item`, `frontier_artifact`

**Formal items** (`theorem`, `exercise`, `certificate_claim`, `benchmark_item`,
`frontier_artifact`, and any `concept` with a proof) require: `lean_module`,
`theorem_name`, `imports`, `toolchain`, `formal_statement_pp`, and
`hashes.formal_statement_sha256`.

## `status`
`kernel_verified`, `verified_certificate`, `formula_fact_only`, `empirical_only`,
`failed_attempt`, `redacted_public_metadata_only`

## `difficulty_bin`
`D0` exact rewrite/automation · `D1` short human proof · `D2` needs retrieval/nontrivial
tactics · `D3` structured multi-lemma · `D4` certificate-backed/known theorem ·
`D5` frontier/quarantined only

## `trust`
- `rung`: `0`–`5` (0 = labeled negative example, never proof-bearing)
- `proof_authority`: `lean_kernel`, `lean_verified_lrat`, `kernel_rechecked_witness`, `none`
- `certificate_checker`: `kernel_decide`, `bv_decide_lrat`, `model_eval`, `lrat_import`, `none`
- `formula_fact_status`: `proved`, `not_applicable`, `failed`
- `math_fact_status`: `proved`, `formula_fact_only`, `empirical_only`
- `encoding_soundness_status`: `not_applicable`, `stated_directly`, `proved`, `missing`
- `independent_review_status`: `none`, `self_reviewed`, `repo_reviewed`, `external_reviewed`
- `public_claim_class`: `public_safe`, `restricted`, `private_only`

## `training.eligibility`
`public_train`, `public_val`, `public_test`, `heldout_public`, `heldout_private`,
`quarantined`, `quarantined_benchmark`, `negative_example_only`, `private_audit_only`,
`disallowed`

## `training.contamination_risk`
`low`, `medium`, `high`

## `certificate`
- `certificate_type`: `lrat`, `drat`, `sat_model`, `cnf_witness`, `none`
- `certificate_checker`: `bv_decide_lrat`, `lrat_import`, `model_eval`, `none`
- `memory_class`: `small`, `medium`, `large`

## `source_provenance`
- `source_kind`: `author_written`, `adapted_public_source`, `formal_conjectures`,
  `erdos_problems`, `proofnet_style`, `repo_original`, `imported_open_repo`,
  `benchmark_statement`, `private_audit`
- `statement_fidelity`: `author_written`, `canonical_statement_hash_match`,
  `problem_fidelity_verified`, `adapted_with_review`, `unknown`

## Hashes (all lowercase-hex SHA-256)
`source_sha256`, `formal_statement_sha256`, `proof_body_sha256`, `module_sha256`,
`canonical_cnf_sha256`, `certificate_sha256`, `private_artifact_bundle_sha256`,
`packet_sha256` (required).

### Canonicalization rules
- `packet_sha256` — SHA-256 over the canonical JSON of the packet with
  `hashes.packet_sha256` removed (sorted keys, UTF-8, LF, no BOM, compact separators).
- `formal_statement_sha256` — SHA-256 over canonical JSON of
  `{theorem_name, formal_statement_pp, toolchain}`.
- `source_sha256` / `proof_body_sha256` / `module_sha256` — SHA-256 over the exact bytes
  of the referenced file, LF-normalized, no BOM.
- `canonical_cnf_sha256` — SHA-256 over the canonical DIMACS serialization emitted by the
  pinned Lean-side serializer (`dimacs_serializer_version`). DIMACS is an exchange format,
  not the source of authority.
