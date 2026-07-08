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

Min/max family: `avg_between_min_max` (`min a b <= (a+b)/2 <= max a b`),
`min_add_min_le` (min is superadditive).

- [x] `max_add_le` — `max (a+b) (c+d) <= max a c + max b d` (D1, L1), i.e.
      max is subadditive; the dual companion to `min_add_min_le`. Authored
      2026-07-08 via tracked episode
      `a6eb2a43-9d19-427d-a2e3-bbc8c60dc9a7` (kernel_verified on the first
      attempt: `max_le`, `le_max_left`/`le_max_right`, closed by
      `linarith`).

- [x] `amgm_wrong_direction_counterexample` — explicit disproof (witness
      a=1, b=9) that the flipped AM-GM direction `(a+b)/2 <= sqrt(a*b)`
      is false in general. Authored 2026-07-08 via tracked episode
      `5c239fdd-ef5b-440d-b070-16de9d7d95c0` (kernel_verified on the first
      attempt). Paired negative example
      `negative.inequalities.amgm_wrong_direction_bare_nlinarith_failure.v1`
      (episode `ade3dee6-5a63-4a59-bf1a-0ec4e86c89aa`) resolves the
      queued "AM-GM in the wrong direction" candidate in
      `packets/negative/inequalities/QUEUE.md`.

## Next targets

*(empty — see Backlog.)*

## Backlog

- [ ] General `n`-term AM-GM (L2/L3 — likely needs `InequalityEstimateKit`;
      defer until the 2/3/4-term ladder above is in place).
- [ ] v0.1's numeric release criteria (>=250 public, >=25 negative) were
      both met this session — remaining work here is for quality/balance
      (level-distribution gaps, fresh techniques), not raw count.
