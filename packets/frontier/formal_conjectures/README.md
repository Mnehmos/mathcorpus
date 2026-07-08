# Formal Conjectures (Frontier)

Packets sourced from the upstream Formal Conjectures repository, using
`domain: frontier`, `level: L7_frontier`, and
`source_provenance.source_kind: formal_conjectures` per
`schema/ENUMS.md`. This is Phase 5 (`docs/roadmap.md`) — not yet started
at scaffold time (no packets exist here yet).

Formal Conjectures packets are **not** the same as elementary curriculum
packets: they start as statement packets, and only become proof packets
after Lean verification through the tracked proof-search loop. They only
become training-eligible after statement fidelity, source attribution,
proof verification, redaction policy, and export policy are all recorded
(see `STATEMENT_FIDELITY.md` and the schema's `training` object).

Open conjectures are not treated as easy proof targets. For open problems,
build dossiers, attack plans, source maps, partial lemmas, and failed-route
traces unless there is a concrete formal path.

- Import rules: see `IMPORT_POLICY.md`
- Source tracking: see `SOURCE_MAP.md`
- Fidelity review: see `STATEMENT_FIDELITY.md`
- Solved-but-unformalized queue: see `SOLVED_QUEUE.md`
- Open problems queue: see `OPEN_QUEUE.md`
- Proof attempt log: see `PROOF_ATTEMPTS.md`
- Stalled work: see `BLOCKERS.md`
- Run this folder: see `LOOP.md`
- Packet shape: see `PACKET_TEMPLATE.md`
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
