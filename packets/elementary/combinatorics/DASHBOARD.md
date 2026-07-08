# Dashboard — Combinatorics (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 45 |
| Level breakdown | see individual packets — includes `card_union_not_additive.v1.json` (another concurrent agent's addition, commit `246ca69`) not itemized below |

Additions this session (2026-07-08, all kernel-verified via the tracked
proof-search loop, one `solve` step each unless noted):
`card_union_add_card_inter'` (inclusion-exclusion identity, pairs with the
domain's first negative example), `disjoint_union_card'` (equality
companion to `card_union_le'`), `pigeonhole_3_into_2` (domain's first
pigeonhole packet), `card_powerset'` (domain's first `powerset` packet),
the `Nat.choose` starter family `choose_zero_right'`/`choose_self'`/
`choose_symm'`, `card_image_le'`, `choose_succ_succ''` (Pascal's rule),
`sum_range_choose'` (binomial-sum-is-2^n, ties `Nat.choose` back to
`card_powerset'`), and `card_biUnion_le'` (indexed-union generalization of
`card_union_le'`). Full episode IDs are in each packet's own
`verification.episode_id` field — see `git log` for this file for prior
per-packet detail if needed.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
