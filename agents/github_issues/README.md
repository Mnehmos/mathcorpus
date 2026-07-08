# Dev Issue Loop

The dev-agent home for MathCorpus. Its job is **not** to create packets —
its job is to keep `Mnehmos/mathcorpus` healthy by continuously working
open GitHub issues, especially schema/validator bugs, hash/manifest bugs,
export bugs, redaction-audit bugs, and CI/workflow friction. The dev agent
keeps the toolchain (`tools/*.py`, `schema/`, `.github/workflows/ci.yml`)
healthy while the domain agents fill the corpus.

- Run this loop: see `LOOP.md`
- Triage state: see `TRIAGE.md`
- Bug tracking: see `BUGS.md`
- Feature tracking: see `FEATURES.md`
- Completed work: see `DONE.md`
- Filing a new issue: see `ISSUE_TEMPLATE.md`
- Session handoff: see `HANDOFF.md`

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
