# RL transition dataset (issue #9)

A canonical `state -> action -> reward -> next_state` RL transition dataset, distinct from
`packets.jsonl`/`train.jsonl` (theorem records) and never confused with them. Schema:
[`../schema/mcip/v1/rl_transition.schema.json`](../schema/mcip/v1/rl_transition.schema.json);
enum/field notes: [`../schema/ENUMS.md`](../schema/ENUMS.md#rl-transitions-rl_transition-mcip-records-9).

## Cross-repo status — read this before running anything here

Issue #9 was filed with an explicit dependency: *"This issue should consume the transition
format produced by `llm-driven-proof-search#238`."* As of this writing, **neither `#238` nor
its own prerequisite `#231` has shipped any implementation** in
`llm-driven-proof-search` — `#238`'s JSON shape is a proposal in the issue body, not a
released exporter, and `#231` (persisting real reward/terminated/truncated/observation values
in the runtime in the first place) is also still open. There is no real transition data to
import yet.

Given that, this pass built the **consumer side first**, deliberately accepting some rework
risk if the upstream shape shifts once `#238` actually ships:

- `schema/mcip/v1/rl_transition.schema.json` — the record schema, modeled on `#238`'s
  proposed shape plus every field `#9` itself lists as required-or-explicitly-unavailable.
- `tools/mathcorpus/rl_transitions.py` — bundle loading/validation, packet-join,
  publication-eligibility, per-episode contiguity, and the missing-field honesty check.
- `tools/export_rl_transitions.py` — the CLI: validate -> join -> policy-filter -> canonical
  JSONL + episode manifest.
- `schema/mcip/v1/fixtures/rl_episode_success.bundle.json` and
  `rl_episode_legacy_gap.bundle.json` — synthetic conformance fixtures (`export_eligibility:
  "private_only"`, so they can never leak into a public export even by accident) proving the
  pipeline itself works, since there is no real trajectory data to test against.

**What is explicitly not done yet**, because building it now would mean guessing at a shape
`#238` hasn't committed to:

- No real end-to-end test against actual Proof Search output — only the synthetic fixtures.
- No Parquet export with native scalar columns (`#9` scope item) — deferred until real column
  distributions exist to design against, mirroring how `tools/export_parquet.py`'s packet
  columns were only added once real enrichment data existed (issue #5).
- No dataset-card / aggregate-statistics generation (`#9` scope item) — same reason.
- `rl_transitions/` has no on-disk catalog directory yet in this repo; one will appear the
  first time a real bundle is imported. There's nothing to commit for an empty directory.

If `#238`'s actual shape differs from what's modeled here once it ships, expect a schema
**minor** bump (new optional fields) in the common case, or a **major** bump (new `v2/`
directory, per `schema/mcip/v1/README.md`'s fail-closed versioning policy) if a required
field's meaning changes.

## Running it today

Only the conformance fixtures exist to run against:

```
python tools/export_rl_transitions.py schema/mcip/v1/fixtures/rl_episode_success.bundle.json schema/mcip/v1/fixtures/rl_episode_legacy_gap.bundle.json --out exports/
```

This validates both fixture bundles, joins their transitions to
`elementary.algebra.add_assoc.v1`, runs the honesty and episode-contiguity checks (both
fixtures pass with 0 findings), and correctly exports **0** public rows — both fixtures are
`export_eligibility: "private_only"` by design, so this is the expected, safe outcome, not a
bug. `rl_episode_manifest.json` will likewise be empty for the same reason.

Once a real bundle exists (once `llm-driven-proof-search#238` ships), the same command works
unmodified against `rl_transitions/` or any directory of bundle files.

## Design decisions worth knowing

- **Never folded into a packet.** Every other MCIP record type (`attempt_record`, `model_run`,
  ...) gets folded into that packet's own JSON via `tools/import_mcip.py`. `rl_transition`
  records are not — an episode can have thousands of steps, and a packet has exactly one
  proof. They live as their own dataset instead, exported straight from bundles.
- **A transition can never be more exportable than its packet.**
  `rl_transitions.is_publicly_exportable` requires both the transition's own
  `export_eligibility == "public"` and the joined packet's `training.eligibility` to already
  be public/heldout-public. A quarantined or `private_audit_only` packet's steps stay private
  even if an individual transition record was (incorrectly) stamped public — the packet-level
  restriction is always authoritative, matching the child-evidence relationship described in
  `schema/mcip/v1/README.md`.
- **Honesty over fabrication.** `reward`, `terminated`, `truncated`, `action`, `state`,
  `next_state`, and `outcome` are all required *keys* but individually nullable *values*. A
  null is only accepted when `missing_field_reasons` names that field with a real reason
  (e.g. citing `llm-driven-proof-search#231`). This is checked by
  `rl_transitions.check_transition_record`, not by the JSON Schema itself, since "field A null
  implies field B must be non-empty" cross-field rules live in `tools/mathcorpus/policy.py`
  and friends throughout this repo, not in `schema/`.
