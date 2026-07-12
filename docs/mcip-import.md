# MCIP import, packet enrichment, and backfill

How MCIP bundles (`schema/mcip/v1/`, see [`../schema/mcip/v1/README.md`](../schema/mcip/v1/README.md))
become packet child records (`proof_variants`, `dependency_manifest`, `attempts`,
`negative_examples`, `repair_trajectories`, `model_runs`, `empirical_difficulty_aggregates`
— issues #2-#5), and what this repo can and cannot recover for packets authored before this
tooling existed.

## Importing a bundle into existing packets

```
python tools/import_mcip.py <bundle_or_dir>                       # dry-run (default)
python tools/import_mcip.py <bundle_or_dir> --apply
python tools/import_mcip.py <bundle_or_dir> --apply --quarantine-report manifests/import_quarantine.json
```

`tools/import_mcip.py` never creates a new packet and never touches a packet's own
canonical identity fields (`packet_id`, `title`, `theorem_name`, `formal_statement_pp`,
`hashes`, `trust`, `training`, ...) — only its child-record fields. The mapping from MCIP
record shape to packet-embedded shape lives in `tools/mathcorpus/mcip_import.py`
(`fold_proof_variant`, `fold_dependency_manifest`, etc.); `restriction_profile` records go
to the shared `restriction_profiles/` catalog instead of into a packet.

**Safety model:**

- A structurally invalid bundle (schema or hash failure) is rejected outright — nothing is
  written.
- A bundle whose `packet_identity.packet_id` doesn't resolve to an existing packet, or whose
  `formal_statement_sha256` disagrees with that packet's own, is quarantined whole.
- Within an otherwise-valid bundle, each record that would conflict with an existing,
  differently-shaped entry is quarantined **individually** — everything else in the same
  bundle still applies. Conflicting evidence is never silently selected over what's already
  there; run with `--quarantine-report` to get a machine-readable list of what was skipped
  and why.
- Re-running the same bundle against the same packet state is a no-op: already-applied
  records are recognized (by id and content equality) and skipped, not duplicated. This is
  what makes a large batch of bundles **resumable** — a partial prior run can simply be
  re-run from the top.
- After `--apply`, `hashes.packet_sha256` (and `formal_statement_sha256`, for formal items)
  are recomputed in place via `mathcorpus.hashing.compute_hashes` — the written file is
  already hash-consistent; run `validate_packets.py --check-hashes` to confirm.

## Authoring a new packet from a verifier export

`tools/author_packet.py`'s batch spec accepts an optional `verifier_export_bundle` field
per packet — an MCIP bundle path folded in via the same `mathcorpus.mcip_import` logic the
importer uses, so a freshly authored packet and a backfilled one populate their child
records identically. This is the "enriched path" issue #6 asks new Proof-Search-generated
packets to use by default, in place of hand-copying `dependency_manifest`/`theorem_deps`
into the spec. If a bundle record disagrees with a manually specified spec field, it is
reported as a conflict and not applied — the manual field is never silently overwritten. See
the spec docstring in `tools/author_packet.py` for the exact shape.

## Backfilling the existing corpus

```
python tools/backfill_report.py packets/ --out manifests/backfill_report.json
```

Per packet, reports one of four statuses for each of seven recoverable-target categories
(tactics/proof shape, proof profile, explicit dependencies, episode/trajectory linkage,
attempts/diagnostics, model hashes/tokens/cost/timing, proof variants/repair chains):

- `recovered` — already present as a structured child record.
- `not_yet_backfilled` — could exist, doesn't yet; worth importing more evidence for. Not
  lost — a future `import_mcip.py --apply` run (or manual review) can still fill it in.
- `unrecoverable_missing` — the source data needed to recover this field no longer exists in
  any store this environment can reach.
- `not_applicable` — this packet's kind/status means the field doesn't apply (e.g. a
  standalone `negative_example` packet has no `proof_body_path` to derive shape from).

**Honest limitation**: this environment has no access to Proof Search's retained trajectory
database or artifact store — only what's already checked into this repo (packet metadata,
Lean source files, and whatever a real MCIP bundle has already been imported). That means
`attempts_and_diagnostics` and `model_hashes_tokens_cost_timing` are `unrecoverable_missing`
for nearly every packet authored before this tooling existed, and will stay that way unless
a real MCIP export from Proof Search's own retained data is produced and imported —
`backfill_report.json` marks this explicitly rather than silently reporting it as absent.
Re-run the report after every real import batch to see it improve.

## Trajectory/artifact resolution (optional, policy-gated)

`tools/validate_packets.py --artifact-index <path>` accepts a JSON file mapping
`episode_id -> {trajectory_first_hash, trajectory_last_hash}` and, when supplied, requires
every `verifier: proofsearch` packet's provenance claims to resolve against it
(`policy.check_trajectory_artifact_resolution`). This satisfies "Proof Search provenance
claims resolve to trajectory and artifact records **when policy allows**" — it is opt-in by
design, since no such index exists yet in this environment; supplying one is left to
whichever process eventually has access to Proof Search's real trajectory store.
