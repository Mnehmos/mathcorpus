# Trace Policy — Induction (Elementary)

All meaningful proof work for packets in this folder must go through the
tracked proof-search MCP loop (`docs/proofsearch-integration.md`), not
private reasoning:

- Formal statements and proof attempts — via `episode_step`, never a side
  channel.
- Failed/abandoned attempts — preserved as `negative_example` packets
  (`kind: negative_example`, `status: failed_attempt`, `trust.rung: 0`),
  not deleted.
- Mathlib lookups, tactic diagnostics, and repairs — part of the episode
  trajectory.
- Trust labels (`trust.rung`, `trust.proof_authority`) set by the
  mechanism the ledger recorded, never by the desired result.

Private reasoning is not proof authority. A proof is a candidate until the
pinned Lean kernel checks it inside a tracked episode.

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
