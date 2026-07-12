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

## `proof_variants[]`

Zero or more additional proofs of a packet's statement (`$defs/proof_variant`). Adding a
variant never changes the packet's own canonical `theorem_name` /
`formal_statement_pp` / `hashes.proof_body_sha256` — those stay defined by the packet's own
top-level fields regardless of how many variants exist. Cross-field checks live in
`tools/mathcorpus/policy.check_proof_variants`:

- a variant's `formal_statement_sha256` / `environment_hash` must match the parent packet's
  `hashes.formal_statement_sha256` / `verification.environment_hash` when both are set;
- a `canonical`-styled variant's `proof_body_sha256` must match the parent packet's
  `hashes.proof_body_sha256`.

- `variant_style`: `canonical`, `shortest`, `pedagogical`, `restricted`, `interactive`,
  `alternate_model`. A `restricted` variant requires `restriction_profile_id` +
  `restriction_profile_sha256`.
- `source`: `human_authored`, `proof_search`, `imported`.
- `proof_profile.primary_proof_class` / `secondary_proof_classes`: `theorem_lookup`,
  `normalization`, `arithmetic_automation`, `induction`, `witness_construction`,
  `case_analysis`, `multi_lemma_composition`.
- `proof_profile.automation_level`: `none`, `assisted`, `semi_automated`,
  `fully_automated`.

## `dependency_manifest`

Richer, Proof-Search-sourced dependency evidence (`$defs/dependency_manifest`), additive to
the shallow top-level `dependencies` object. Distinguishes what was **declared**, **used**,
raised as a proof-search **obligation**, confirmed as a **verified module item**, offered as
a **retrieval candidate**, or **retrieved but unused** — six distinct categories, not one
merged list. `claim_sources[]` records, per dependency id, which category it belongs to and
whether that claim came from a human (`manual`), an MCIP import (`proof_search_import`), or
a verifier export (`verifier_export`).

Cross-field checks (`tools/mathcorpus/policy.py`):

- `check_dependency_manifest` (per packet): `environment_hash` must match the parent
  packet's `verification.environment_hash`; a dependency id cannot be claimed both `used`
  and `retrieved_unused` (direct contradiction); every `claim_sources[]` entry's
  `dependency_id` must actually appear in the array its `category` names.
- `check_dependency_manifest_refs` (corpus-wide): any dependency id shaped like a
  MathCorpus `packet_id` must resolve to a real packet (no dangling references) and must
  not form a cycle through other packets' manifests. Mathlib declaration names (not
  packet-id-shaped) aren't checkable this way — there is no local Mathlib index to resolve
  against.

`tools/build_manifests.py` aggregates `dependency_manifest` data corpus-wide into
`manifests/dependency_graph.json`'s `dependency_manifest_summary`: frequency per dependency
id per category, and min/max/avg transitive depth across packets that carry a manifest.

**Not yet a blocking gate**: the roadmap (issue #2 of the MCIP series) calls for
kernel-verified Proof-Search packets to *reference* a dependency manifest. Enforcing that as
a hard `validate_packets.py` error today would fail every one of the ~350 packets authored
before this field existed. It is deferred to the corpus-wide backfill (issue #6); until
then, `dependency_manifest` is opt-in and validated only when present.

## `attempts[]`, `negative_examples[]`, `repair_trajectories[]`

Packet-embedded evidence for the tracked attempts that led to a packet's current state,
mirroring MCIP's `AttemptRecord`/`NegativeExample`/`RepairTrajectory` from #1. Additive to
the packet-level `failure` object (which describes a whole `kind: negative_example` packet
narratively); these instead let *any* packet — most usefully a successful one — carry its
own attempt history, including the failed tries along the way.

- `attempts[].outcome`: `succeeded`, `failed`, `abandoned`.
- `attempts[].diagnostics[].category` is free text (not a closed enum) so it can name any
  Lean diagnostic; the categories this schema was built to support are `parse_failure`,
  `unknown_declaration`, `type_mismatch`, and `unsolved_goals` — see the diagnostics
  conformance fixture below.
- `negative_examples[].origin`: `organic` (arose from a real tracked attempt) or
  `controlled_mutation` (deliberately produced to exercise a diagnostic path).
  `proof_authority` is fixed to `"none"` at the schema level — a negative example can never
  confer proof authority on its parent packet.
- `repair_trajectories[].steps[].step_hash`: SHA-256 over canonical JSON of
  `{step_index, from_attempt_id, repair_action, diagnostic_category_addressed, to_ref}` —
  see `tools/mathcorpus/hashing.repair_step_hash`. This is what makes a chain
  "hash-linked": a step cannot be silently reworded without changing its hash.
- `repair_trajectories[].terminal_ref`: for `verified_proof`, either a `proof_variants[]`
  entry in the *same* packet, or — when the successful proof was filed as its own packet —
  that packet's `packet_id` (checked corpus-wide, not just locally). For `explicit_failure`,
  an `attempts[]` entry in the same packet.

Cross-field checks live in `tools/mathcorpus/policy.py`: `check_attempts_and_repairs`
(per packet — dangling attempt/variant references, step ordering, step-hash staleness,
diagnostic-category consistency between a negative example and its attempt) and
`check_repair_trajectory_refs` (corpus-wide — a cross-packet `terminal_ref` must resolve to
a real packet).

**Fixtures**: `packets/negative/number_theory/gcd_dvd_omega_no_gcd_theory.v1.json` carries a
real `unsolved_goals` attempt and a real successful repair (its own episode's second step
already exists as `packets/elementary/number_theory/gcd_dvd_left.v1.json`, referenced by
`terminal_ref`). `packets/negative/_fixtures/diagnostic_categories_conformance.v1.json`
covers `parse_failure`, `unknown_declaration`, and `type_mismatch` with illustrative (not
real-telemetry) diagnostics — it is explicitly `training.eligibility: private_audit_only` so
it never reaches a public or negative-example export.

## Restriction profiles (`restriction_profiles/`)

A restriction profile is a hash-pinned, reusable constraint set (forbidden/allowed
tactics, dependency budget) that a `restricted` proof variant was checked against. Profiles
are their own catalog — `restriction_profiles/<id>.v1.json`, one file per profile,
conforming to [`mcip/v1/restriction_profile.schema.json`](mcip/v1/restriction_profile.schema.json)
— not embedded per-packet, so the same profile can be referenced by many packets'
`proof_variants[].restriction_profile_id`. `tools/stamp_restriction_profiles.py` computes
each entry's `record_hash`; `tools/validate_packets.py` structurally validates the catalog
and checks that every packet's `restriction_profile_id` + `restriction_profile_sha256` pin
resolves to a current catalog entry (`tools/mathcorpus/policy.check_restriction_profile_refs`).

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
