# Dashboard — Inequalities (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 22 |
| Level breakdown | L0_elementary: 4 · L1_proof_basics: 3 · L2_olympiad: 15 |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/inequalities/`; this file
previously grew an unbounded per-packet bullet list and has been
condensed (same fix already applied to the combinatorics and induction
dashboards this session). Highlights: this domain started heavily skewed
toward `L2_olympiad` named inequalities (AM-GM ladder, Nesbitt, Schur);
recent cycles have been deliberately adding `L0`/`L1` absolute-value
basics (`abs_add_le`, `abs_add_three`, and this cycle's `abs_sub_le`, the
metric-distance triangle inequality) to offset that skew.

Next targets: see `QUEUE.md`.
