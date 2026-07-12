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

## `model_runs[]`, `empirical_difficulty_aggregates[]`

Multi-model empirical difficulty evidence, mirroring MCIP's `ModelRun`/
`EmpiricalDifficultyAggregate` from #1. Strictly additive: nothing in this repo ever writes
to a packet's own top-level `difficulty_bin` (the author-assigned bin) from this data — the
two are deliberately kept apart, and `empirical_difficulty_aggregate.author_difficulty_bin`
is only ever an *echo* of what the author bin was at aggregation time, for comparison.

- `model_run.censored_fields[]`: names of fields on that record whose true value is known
  but deliberately withheld (e.g. by export/redaction policy) — distinct from `null`, which
  means "not collected". This is how "missing or censored model metadata is represented
  honestly" is satisfied: the schema never conflates the two.
- `empirical_difficulty_aggregate.calibration_version`: currently only `"v1"` is defined.
  `tools/mathcorpus/difficulty.py` implements it: `observed_difficulty_score` is `1 -`
  the unweighted mean `eventual_pass_rate` across the aggregate's referenced `model_runs`
  (runs missing a rate are excluded, not treated as 0); `calibrated_difficulty_bin` maps
  that score through fixed thresholds (`≤0.05→D0 … >0.90→D5`). A future recalibration gets
  a new version rather than silently changing what an existing stored score means.
  `tools/mathcorpus/policy.check_empirical_difficulty_aggregates` recomputes both from the
  packet's own `model_runs` and rejects a mismatch — **aggregates are reproducible, not just
  asserted.** Multiple aggregates (different suites, or repeated historical runs) may
  coexist on one packet; an exact-duplicate `(evaluation_suite_version, policy_version,
  calibration_version, model_run_ids)` signature is flagged as a warning, not blocked.

**Corpus-level reporting**: `tools/mathcorpus/aggregates.py` (shared by
`build_manifests.py`'s `dependency_graph.json` and `corpus_stats.py`) summarizes proof-class
distribution, dependency transitive depth, negative-example counts (standalone packets vs.
embedded), and per-model-family episode-weighted pass rate. `tools/export_parquet.py` hoists
the same enrichment summaries (`proof_variant_count`, `canonical_proof_class`,
`dependency_transitive_depth`, `attempt_count`, `negative_example_count`,
`best_eventual_pass_rate`, `observed_difficulty_bin`, …) into native Parquet columns instead
of leaving them reachable only by parsing the `packet_json` string column. JSONL exports
already expose nested fields natively (each row is a full JSON object), so no change was
needed there.

**Fixture**: no packet in this corpus has real multi-model evaluation data yet — the
roadmap's Phase 7 evaluation suite hasn't started (`docs/roadmap.md`). Rather than fabricate
comparative pass rates for a real packet,
`packets/_fixtures/model_performance_conformance.v1.json` is a new, explicitly synthetic
fixture (`kind: concept`, `training.eligibility: private_audit_only` — excluded from every
export lane) with two illustrative model runs and a genuinely recomputed aggregate.

## Literature lineage (`idea_attributions[]`, `prior_art_matches[]`, `citation_reviews[]`, `contribution_statements[]`)

Formal correctness, source provenance, and intellectual lineage are separately auditable.
Mirrors MCIP's `IdeaAttribution`/`PriorArtMatch`/`CitationReview`/`ContributionStatement`
(new record types added in #7 — see `schema/mcip/v1/` for the full set including
`LiteratureSource`/`RetrievedPassage`/`ExternalClaim`). Never changes kernel-verification
status: this is child evidence about provenance, not proof authority.

- **`literature_sources/`** is a shared, hash-pinned, reusable catalog (same pattern as
  `restriction_profiles/`) holding `LiteratureSource` (bibliographic metadata),
  `RetrievedPassage` (a model-visible excerpt — its existence as a record IS the evidence
  the model saw it, tied to a `retrieval_episode_id`), and `ExternalClaim` (a specific claim
  a source asserts, decoupled from whether it influenced any proof). Structurally validated
  by `tools/validate_packets.py`; stamped by `tools/stamp_literature_sources.py`.
- **`idea_attributions[].visibility`**: `model_visible` (available to/seen during proof
  search, typically backed by a `RetrievedPassage`) or `post_hoc` (discovered only during
  later review). `attribution_status`: `directly_used`, `likely_influential`,
  `background_only`, `independent_rediscovery`, `uncertain`, `not_used`.
  `source_sha256_pin` hash-pins the referenced catalog entry, checked by
  `policy.check_literature_source_refs` exactly like `restriction_profile_sha256`.
- **`prior_art_matches[]`** are inherently post-hoc by record type alone — no `visibility`
  field needed. That structural separation (a different record type, not a shared field) is
  what keeps model-visible influence and post-hoc discovery from being conflated.
  `match_type`: `same_result`, `stronger_result`, `weaker_result`, `related_technique`,
  `independent_rediscovery`.
- **`citation_reviews[]`**: multiple, even disputed, reviews coexist as separate array
  entries — a new review never overwrites an earlier one. `supersedes` points backward to
  an earlier review it updates, preserving history instead of editing it away.
  `review_status`: `endorsed`, `disputed`, `needs_more_evidence`.
- **`contribution_statements[].contribution_class`**: `new_proof`, `independent_rediscovery`,
  `formalization`, `verification`, `reconstruction`, `adaptation`,
  `literature_derived_synthesis` — the same vocabulary issue #8's publication policy
  requires. Kernel verification alone never implies a class; this is a separate, explicit
  editorial claim.

Cross-field checks: `policy.check_literature_lineage` (per packet — dangling
attribution/prior-art references within `citation_reviews`/`contribution_statements`,
statement-hash consistency) and corpus-wide `policy.check_literature_source_refs` (dangling
catalog references, stale hash pins) + `policy.check_literature_source_catalog` (a
`RetrievedPassage` marked `passage_redacted` must not still carry `passage_text` — the same
redaction-contradiction rule already applied to `proof_body_redacted`).

**Fixture**: the acceptance criterion names "CDC" with "prior Fano-flow work" — neither
exists anywhere in this repo (confirmed by search) or in this project's known history; it
appears to reference work external to this corpus. Rather than fabricate that scenario,
`packets/frontier/formal_conjectures/union_closed_sharpness.v1.json` — a real packet whose
own pre-existing notes already document its FormalConjectures source, Wikipedia background,
and a distinct prior-art bound (Yu 2023) — was enriched instead, with its formal-verification
contribution (`contribution_class: "adaptation"`) identified separately from that prior art.
See the closing comment on issue #7 for the full substitution rationale.

## Publication readiness (`publication`)

A separate review dimension from `trust`/proof authority: a kernel-verified packet may
still be misleading if its public presentation omits prior work or overstates novelty.
`publication.status` never affects `trust.rung` / `proof_authority` / `status`, and no code
path in this repo lets it — citation or novelty uncertainty changes public claim status
only, never proof truth.

- **`status`**: `metadata_only`, `kernel_verified_unreviewed`, `citation_review_pending`,
  `novelty_review_pending`, `reviewed_with_caveats`, `publication_ready`,
  `blocked_missing_attribution`, `blocked_novelty_claim`.
- **Absent `publication` is valid, not an error** — existing packets remain valid under an
  implicit default (`tools/mathcorpus/policy.implicit_publication_status`):
  `kernel_verified_unreviewed` for a kernel-verified packet, `metadata_only` otherwise. This
  is the "legacy/unreviewed until migrated" state the acceptance criteria ask for.
- **`policy.check_publication_status`** gates only `publication_ready` (every other status
  is self-limiting and needs no extra checking):
  - `publication_ready` with zero `contribution_statements` is rejected — kernel
    verification alone can never establish it.
  - `publication_ready` on an `open_problem_related: true` packet requires at least one
    *current* (not `supersedes`-ed away) `citation_review` with `review_status: "endorsed"`.
  - A `contribution_class: "new_proof"` declaration ("strong novelty language") is blocked
    from `publication_ready` unless a current review is endorsed — a disputed or missing
    review blocks it outright.
- **Corrections without rewriting history**: a `citation_review` with `supersedes` pointing
  to an earlier review's `review_id` updates the record without deleting it;
  `policy.check_literature_lineage` rejects a `supersedes` that doesn't resolve locally.
- **Exports carry both forms of the contribution statement**: `mathcorpus.export.contribution_summary`
  renders a human-readable sentence (contribution class, known prior art, publication
  status, unresolved caveats) added to every exported row as `contribution_summary`; the
  machine-readable form is the raw `contribution_statements`/`publication` fields, already
  present in the same row.

**Fixture**: same substitution as #7 — "CDC" doesn't exist in this repo.
`union_closed_sharpness.v1` carries `publication.status: "reviewed_with_caveats"` (not
`publication_ready`): it has an endorsed review, but `unresolved_attribution_caveats` names
the Yu-2023 citation's unverified bibliographic precision honestly rather than claiming full
readiness it hasn't earned.

## Importing MCIP bundles / backfilling the corpus

`tools/import_mcip.py` folds an MCIP bundle's records into the child-record fields above
(idempotent, conflict-quarantining, dry-run by default); `tools/backfill_report.py` reports
per-packet recovery status for the existing corpus. See
[`../docs/mcip-import.md`](../docs/mcip-import.md) for the full workflow, safety model, and
an honest accounting of what cannot be recovered without a retained Proof Search trajectory
store.

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
