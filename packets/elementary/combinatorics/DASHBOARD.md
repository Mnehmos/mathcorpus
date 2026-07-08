# Dashboard — Combinatorics (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 53 |
| Level breakdown | see individual packets |

Per-packet history (episode IDs, tactic scripts, lessons learned) lives
in each packet's own `verification.episode_id`/`notes` fields and in
`git log -- packets/elementary/combinatorics/`; this file previously grew
an unbounded per-packet bullet list and has been condensed here (same
cleanup already applied to induction/inequalities this session).

Focus-area coverage as of 2026-07-08: `Finset` cardinality (union,
intersection, set difference, indexed union, image, powerset, filter
partition), `Nat.choose` basics + Pascal's rule + binomial sum, pigeonhole
(concrete + general), finite products/sums (including the fundamental
counting principle `card_product`), and the domain's first plain-`Set`
packet (`set_mem_union`). Most sub-areas in the README's focus list now
have at least one packet.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
