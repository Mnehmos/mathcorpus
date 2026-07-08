# Erdős Frontier

The Erdős lane for MathCorpus packets (`domain: frontier`,
`level: L7_frontier`, `source_provenance.source_kind: erdos_problems`):
formalizing known companion results, replacing corpus `sorry`s where
possible, building attack plans, and honestly separating solved, partial,
companion, and open-problem work. This is Phase 5 (`docs/roadmap.md`) —
not yet started at scaffold time.

Anti-hype rule: no open Erdős problem is claimed solved unless the proof is
Lean-verified through a tracked episode, statement fidelity is reviewed,
and the result is clearly separated from known companion theorems or
partial infrastructure.

Existing repo context — the actual Erdős Lean formalization work already
lives in a **sibling repository**, not here:

- `F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\`
  holds the existing per-problem Lean work (e.g. `erdos-9`, `erdos-291`,
  `erdos-672`) and its own `whitepaper.md`.
- `F:\Github\mnehmos.llm-driven-proof-search.environment\docs\erdos\bounty-board.md`
  tracks the existing bounty/target board.

Cross-reference those locations before starting new work here. This folder
exists to turn **already Lean-verified** companion/partial results from
that work into properly schema'd, provenance-complete MathCorpus packets —
it does not duplicate the proof-search work itself.

- Open problems: see `OPEN_PROBLEMS.md`
- Companion results: see `COMPANION_RESULTS.md`
- Partial results: see `PARTIAL_RESULTS.md`
- Stalled work: see `BLOCKERS.md`
- Source review: see `SOURCE_REVIEW.md`
- Run this folder: see `LOOP.md`
- Packet shape: see `PACKET_TEMPLATE.md`
- Whitepaper-eligible results: see `WHITEPAPER_QUEUE.md`
- Evidence-rail rules: see `TRACE_POLICY.md`

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
