# Combinatorics (Negative Examples)

Focus on Finset, Set, membership, union, intersection, filters, cardinality, products, sums, pigeonhole-style basics, and clean finite-object manipulation.

This lane holds labeled, non-proof-bearing `negative_example` packets for Combinatorics — failed/abandoned proof attempts preserved as training data (roadmap v0.1 release criteria calls for ≥25 negative examples corpus-wide).

This folder is both packet storage and a local agent workspace for Combinatorics
(`negative`).

- Run this domain: see `LOOP.md`
- Track progress: see `DASHBOARD.md`
- Next targets: see `QUEUE.md`
- Stalled work: see `BLOCKERS.md`
- Inter-domain dependencies: see `CROSS_DOMAIN.md`
- Evidence-rail rules: see `TRACE_POLICY.md`
- Packet shape: see `PACKET_TEMPLATE.md`
- Completion checklist: see `VALIDATION.md`

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
