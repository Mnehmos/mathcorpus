# Dashboard — Inequalities (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 28 |
| Level breakdown | L0_elementary: 6 · L1_proof_basics: 6 · L2_olympiad: 16 |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/inequalities/`; re-condensed this
cycle (same recurring growth pattern fixed previously in this file and in
induction/combinatorics). Highlights: this domain started heavily skewed
toward `L2_olympiad` named inequalities (AM-GM ladder, Nesbitt, Schur,
Cauchy-Schwarz); recent cycles have deliberately added `L0`/`L1` content
to offset that: absolute-value basics (`abs_add_le`, `abs_add_three`,
`abs_sub_le`, `abs_abs_sub_abs_le`), power-mean extensions
(`three_var_qm_am_bound`), and a growing min/max family:
`avg_between_min_max`, `min_add_min_le` (min is superadditive), and this
cycle's `max_add_le` (D1, L1, episode
`a6eb2a43-9d19-427d-a2e3-bbc8c60dc9a7`: `max (a+b) (c+d) <= max a c +
max b d`, i.e. max is subadditive — the dual companion to
`min_add_min_le`).

Next targets: see `QUEUE.md`.
