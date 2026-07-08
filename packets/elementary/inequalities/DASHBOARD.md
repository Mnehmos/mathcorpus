# Dashboard — Inequalities (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 25 |
| Level breakdown | L0_elementary: 5 · L1_proof_basics: 4 · L2_olympiad: 16 |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/inequalities/`; this file
previously grew an unbounded per-packet bullet list and has been
condensed (same fix already applied to the combinatorics and induction
dashboards this session). Highlights: this domain started heavily skewed
toward `L2_olympiad` named inequalities (AM-GM ladder, Nesbitt, Schur);
recent cycles have been deliberately adding `L0`/`L1` absolute-value
basics (`abs_add_le`, `abs_add_three`, `abs_sub_le` the metric-distance
triangle inequality, `abs_abs_sub_abs_le` the full doubly-absolute
reverse triangle inequality) to offset that skew. Also added this cycle:
`cauchy_three_term` (D2, L2, episode
`3e12e9cc-d08e-45e5-90ef-02c63889deec`), extending `cauchy_two_term` by
one more variable pair via the Lagrange-identity SOS hints, mirroring how
the AM-GM ladder was built up from 2 to 3 to 4 terms. Also
`three_var_qm_am_bound` (D1, L1, episode
`15f8194a-40b6-4b82-bd46-be391c5063d6`), extending `qm_am_bound` (the
two-term case) to three variables via the same three-pairwise-square SOS
hints.

Next targets: see `QUEUE.md`.
