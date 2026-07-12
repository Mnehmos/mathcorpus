# MCIP v1 — MathCorpus Interchange Protocol

A versioned interchange contract shared by MathCorpus and `llm-driven-proof-search`, so
rich proof-search evidence (attempts, repairs, dependency evidence, model performance,
proof-strategy classification) can move between repositories without MathCorpus depending
on Proof Search's internal SQLite schema, and without Proof Search depending on MathCorpus's
packet schema.

## Records vs. packets

MCIP records are **child evidence**, never canonical packet data. A packet's identity,
trust, and training-eligibility fields live in [`../../packet.schema.json`](../../packet.schema.json)
and are never edited by an MCIP import. An MCIP bundle only ever *proposes* evidence that a
downstream MathCorpus tool (`tools/import_mcip.py`, see `docs/mcip-import.md`) may choose to fold
into a packet's own child records. A bundle that fails validation, or whose hashes don't
match the packet it claims to describe, must be rejected or quarantined — never partially
applied.

Eighteen record types, one per file in this directory:

| Record type | File | Purpose |
|---|---|---|
| `packet_identity` | `packet_identity.schema.json` | Binds a bundle to a packet_id + pinned environment. |
| `proof_variant` | `proof_variant.schema.json` | One proof of the packet's statement in a given style. |
| `proof_profile` | `proof_profile.schema.json` | Proof-strategy classification of one variant. |
| `restriction_profile` | `restriction_profile.schema.json` | Hash-pinned, reusable tactic/dependency constraint set. |
| `dependency_manifest` | `dependency_manifest.schema.json` | Declared vs. used vs. retrieved dependency evidence. |
| `attempt_record` | `attempt_record.schema.json` | One tracked proof-search attempt, success or failure. |
| `negative_example` | `negative_example.schema.json` | A preserved failed attempt; `proof_authority` is fixed to `"none"`. |
| `repair_trajectory` | `repair_trajectory.schema.json` | Ordered, hash-linked chain from failure(s) to a terminus. |
| `model_run` | `model_run.schema.json` | One model's evaluation run under a pinned suite/policy. |
| `empirical_difficulty_aggregate` | `empirical_difficulty_aggregate.schema.json` | Difficulty observed across model runs, kept apart from author-assigned difficulty. |
| `literature_source` | `literature_source.schema.json` | A catalog entry for an external paper, repo, or claim. |
| `retrieved_passage` | `retrieved_passage.schema.json` | A specific passage retrieved from a `literature_source`. |
| `external_claim` | `external_claim.schema.json` | A specific claim attributed to a `literature_source`. |
| `idea_attribution` | `idea_attribution.schema.json` | Links a packet's proof idea to the literature it came from. |
| `prior_art_match` | `prior_art_match.schema.json` | A detected prior-art overlap with a packet's result. |
| `citation_review` | `citation_review.schema.json` | Human review of a packet's literature lineage. |
| `contribution_statement` | `contribution_statement.schema.json` | What, if anything, is novel about a packet's result. |
| `rl_transition` | `rl_transition.schema.json` | One `state -> action -> reward -> next_state` environment step from an RL episode (#9). |

`_defs.schema.json` holds shared `$defs` only — it is not a record type and never appears as
a `record_type` value. `bundle.schema.json` is the transport envelope: `{mcip_version,
bundle_id, created_at, producer?, records: [...]}`.

## Every record carries an envelope

`schema_version`, `record_type`, `record_id`, `packet_id`, `environment_hash`, `created_at`,
`trust_status`, `export_eligibility`, `record_hash`, and (record-type permitting)
`artifact_hashes`. Model-related records (`attempt_record`, `model_run`,
`empirical_difficulty_aggregate`, `rl_transition`) additionally carry `model_config_hash` and a
`public_metadata` object — the redaction-aware subset of the record safe to export publicly
even when the full record is `restricted` or `private_only`.

`rl_transition` is unlike every other record type in one respect: it is never folded into a
packet's own child records (a packet has one proof, but an episode can have thousands of
steps). It is instead exported as its own dataset by `tools/export_rl_transitions.py` — see
`docs/rl-transitions.md`.

## Canonical serialization and hashing

Same rule as the rest of the corpus (`tools/mathcorpus/canonical.py`,
`../ENUMS.md#canonicalization-rules`):

- **Canonical JSON**: keys sorted, UTF-8, no ASCII escaping, compact separators
  (`json.dumps(obj, sort_keys=True, ensure_ascii=False, separators=(",", ":"))`).
- **`record_hash`**: SHA-256 over the canonical JSON of the record with `record_hash`
  itself removed. Every other field — including `record_id` — participates, so any content
  change changes the hash. Computed by `tools/mathcorpus/mcip.record_hash`.
- **`environment_hash`**: opaque string, not necessarily SHA-256 — Proof Search's pinned
  Lean+mathlib environment hash format is authoritative; MCIP only requires it be present
  and non-empty.
- File-level hashes referenced from `artifact_hashes` follow the same file-hash rule as
  packet hashes: BOM stripped, CRLF/CR normalized to LF, exact bytes otherwise
  (`tools/mathcorpus/canonical.file_sha256`).

## Fail-closed versioning

- `additionalProperties: false` on every record and on the bundle envelope: an unrecognized
  field fails validation. A new field is only added by a schema change under this
  directory, and the value of `schema_version`/`mcip_version` documents which shape a
  consumer must expect.
- `schema_version` / `mcip_version` follow `1.<minor>.<patch>`. A **minor** bump may add new
  optional fields to an existing record's schema; a **patch** bump is documentation/typo
  only. A **major** bump (a new `v2/` directory) is required for anything that removes a
  field, changes a field's meaning, or changes `additionalProperties` policy.
- A consumer pinned to MCIP `1.x` must reject bundles declaring `mcip_version` `2.x` or
  higher outright, and may accept `1.y` bundles with `y` greater than the versions it was
  built against only if every record in the bundle still validates against the consumer's
  own copy of the `1.x` schemas (i.e. the bundle happens not to use any field the consumer
  doesn't recognize). There is no forward-compatible "ignore unknown fields" mode in v1 —
  that is a deliberate fail-closed choice matching `additionalProperties: false`.

## Validating a bundle

```
python tools/validate_mcip.py schema/mcip/v1/fixtures/success_proof.bundle.json
python tools/validate_mcip.py schema/mcip/v1/fixtures/ --check-hashes
```

`tools/validate_mcip.py` validates structurally (bundle envelope + each record against the
schema named by its own `record_type`) and, with `--check-hashes`, recomputes every
`record_hash` and fails on mismatch. It has no dependency on Proof Search or its SQLite
schema — MathCorpus can validate an MCIP bundle standing alone.

## Conformance fixtures

`fixtures/` contains one bundle per required scenario (see `tools/gen_mcip_fixtures.py`,
which generates them deterministically so their `record_hash` values are always current):

- `success_proof.bundle.json` — a kernel-verified canonical proof with a proof profile and
  dependency manifest.
- `failed_attempt.bundle.json` — a failed attempt preserved as an organic negative example.
- `repair_chain.bundle.json` — a failed attempt repaired into a verified proof variant via a
  one-step repair trajectory.
- `multi_model_aggregate.bundle.json` — two models' runs against the same packet plus their
  empirical difficulty aggregate.
- `rl_episode_success.bundle.json` — a 2-step RL episode (one non-terminal fail, one verified
  close), fully populated. Synthetic: `llm-driven-proof-search#238` has not shipped a real
  producer yet, see `docs/rl-transitions.md`.
- `rl_episode_legacy_gap.bundle.json` — a single step with every core RL field null, each
  justified by a `missing_field_reasons` entry, proving the honesty mechanism itself
  round-trips through validation cleanly (not just the happy path).

Regenerate after any schema change: `python tools/gen_mcip_fixtures.py`.
