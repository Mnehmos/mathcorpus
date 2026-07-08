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

- [x] `three_var_qm_am_bound` — `(a+b+c)^2 <= 3*(a^2+b^2+c^2)` (D1, L1).
      Authored 2026-07-08 via tracked episode
      `15f8194a-40b6-4b82-bd46-be391c5063d6` (kernel_verified on the first
      attempt: `nlinarith [sq_nonneg (a-b), sq_nonneg (b-c),
      sq_nonneg (a-c)]`). Extends `qm_am_bound` (two-term case) to three
      variables, mirroring the AM-GM/Cauchy-Schwarz ladder pattern.

## Next targets

*(empty — see Backlog.)*

## Backlog

- [ ] General `n`-term AM-GM (L2/L3 — likely needs `InequalityEstimateKit`;
      defer until the 2/3/4-term ladder above is in place).
- [ ] v0.1's numeric release criteria (>=250 public, >=25 negative) were
      both met this session — remaining work here is for quality/balance
      (level-distribution gaps, fresh techniques), not raw count.
