# Queue — Inequalities (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 16 existing packets (2026-07-07) to avoid duplicates.

Per-packet history lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/inequalities/`; this file's "Done"
list previously grew an unbounded, repeatedly-headered bullet list
(matching the same growth pattern already fixed in the induction and
combinatorics dashboards this session) and has been condensed here.

## Done (condensed)

Named-inequality ladder (`L2_olympiad`): `am_gm_four_term`,
`nesbitt_three_var` (paired negative example:
`nesbitt_bare_nlinarith_division_failure.v1`), `schur_degree_one`,
`cauchy_three_term` (extends `cauchy_two_term` by one variable pair).

Absolute-value basics (`L0`/`L1`, added to offset the domain's
`L2_olympiad` skew): `abs_add_le`, `abs_add_three`, `abs_sub_le` (metric
triangle inequality), `abs_abs_sub_abs_le` (full doubly-absolute reverse
triangle inequality, strengthening the one-sided `reverse_triangle`).

Power-mean extension: `three_var_qm_am_bound` (extends `qm_am_bound`,
two-term case, to three variables).

- [x] `avg_between_min_max` — `min a b <= (a+b)/2 <= max a b` (D0, L0).
      Authored 2026-07-08 via tracked episode
      `c5bd7202-10dc-4618-bbe8-d3d0ce8cd06f` (kernel_verified on the first
      attempt: `le_total` case split, `min_eq_left`/`min_eq_right`/
      `max_eq_left`/`max_eq_right`, closed by `linarith`). This domain's
      first min/max packet.

## Next targets

*(empty — see Backlog.)*

## Backlog

- [ ] General `n`-term AM-GM (L2/L3 — likely needs `InequalityEstimateKit`;
      defer until the 2/3/4-term ladder above is in place).
- [ ] v0.1's numeric release criteria (>=250 public, >=25 negative) were
      both met this session — remaining work here is for quality/balance
      (level-distribution gaps, fresh techniques), not raw count.
