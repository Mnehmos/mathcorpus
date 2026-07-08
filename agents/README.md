# MathCorpus Agent Workspace

Non-packet agent-workspace scaffolding for MathCorpus. Every packet-storage
domain (`packets/elementary/*`, `packets/negative/*`, `packets/frontier/*`)
carries its own `README.md` / `LOOP.md` / `DASHBOARD.md` / `QUEUE.md` /
`BLOCKERS.md` / `CROSS_DOMAIN.md` / `TRACE_POLICY.md` /
`PACKET_TEMPLATE.md` / `VALIDATION.md` in place; this folder holds the
cross-cutting pieces:

- `status/MATHCORPUS_STATUS.md` — corpus-wide dashboard, owned by the dev
  loop agent below.
- `github_issues/` — the dev loop agent's home: keeps the toolchain
  (`tools/*.py`, schema, CI) healthy by working open GitHub issues on
  `Mnehmos/mathcorpus`.
- `agent_loops/README.md` — index of every `LOOP.md` in the tree.
- `CROSS_DOMAIN_PROMOTIONS.md` — cross-domain lemma/kit promotion queue
  (referenced by every domain's `CROSS_DOMAIN.md`).

Actual reusable Lean kits live in `lean/MathCorpus/` and are declared per
packet via `dependencies.kits` — this workspace does not duplicate that
tree, only tracks *proposals* to promote a pattern into it.


## Global Operating Rule

Do not let proof work escape the proof environment. Per
`docs/proofsearch-integration.md`: evidence is tracked proof-search actions and Lean
kernel verdicts; private reasoning, a prior transcript, or a proof checked some other
way are candidates, not evidence, until the pinned Lean kernel checks them inside a
tracked episode. The Lean kernel decides. The ledger records.
