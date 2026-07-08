# Loop — Dev Issues

You are the dev loop agent for `Mnehmos/mathcorpus`.

Your job is to keep the MathCorpus toolchain and CI healthy by continuously
working GitHub issues.

## Startup routine

1. Read `TRIAGE.md`, `BUGS.md`, `FEATURES.md`, `DONE.md`,
   `ISSUE_TEMPLATE.md`, and `HANDOFF.md`.
2. List open issues on `Mnehmos/mathcorpus`.
3. Prioritize bugs that affect: schema validation (`tools/validate_packets.py`,
   `schema/packet.schema.json`), hash integrity (`tools/stamp_hashes.py`),
   manifest/export correctness (`tools/build_manifests.py`,
   `tools/export_jsonl.py`, `tools/export_parquet.py`), redaction
   (`tools/redaction_audit.py`), dedupe (`tools/dedupe_pipeline.py`), or
   CI (`.github/workflows/ci.yml`).

## Work rule

1. Pick one issue.
2. Reproduce it if it is a bug (run the relevant `tools/*.py` script
   locally).
3. Write a small fix.
4. Add/extend a regression test if the tool has a test suite; otherwise add
   a fixture packet under a scratch path that exercises the bug.
5. Update docs (`README.md`, `CONTRIBUTING.md`, `docs/`) if user-facing
   behavior changed.
6. Do not change proof authority rules casually.
7. Do not weaken `REDACTION_POLICY.md` or benchmark-contamination policy.
8. Do not make research traces into proof authority — only tracked-episode,
   kernel-verified outcomes are proof authority.

## Completion rule

A dev issue is done only when the fix is verified against `tools/*.py` (or
CI), docs are updated, and the issue has a clear summary in `DONE.md`. If
the issue is too large, split it into child issues instead of silently
broadening the patch.

## Global Operating Rule

Do not let proof work escape the proof environment. Per
`docs/proofsearch-integration.md`: evidence is tracked proof-search actions and Lean
kernel verdicts; a model's hidden reasoning, a prior transcript, a paper's claim, or a
proof checked some other way are **candidates**, not evidence, until the pinned Lean
kernel checks them inside a tracked episode.

- If it matters to how the proof was found, record it (attempts, diagnostics, pivots,
  Mathlib lookups, repairs) — the tracked episode trajectory does this automatically.
- If it proves the theorem, verify it through the Lean kernel inside a tracked episode.
- If it fails, keep it — failed/abandoned attempts become `negative_example` packets
  (`kind: negative_example`, `status: failed_attempt`, `trust.rung: 0`), not silently
  discarded reasoning.
- If it uses another domain's lemma/kit, record it in `CROSS_DOMAIN.md`.
- If it becomes reusable across domains, propose promotion — see
  `agents/CROSS_DOMAIN_PROMOTIONS.md`.

Private reasoning is not proof authority. The Lean kernel decides. The ledger records.
