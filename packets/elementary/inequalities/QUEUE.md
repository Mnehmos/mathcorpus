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
`nesbitt_bare_nlinarith_division_failure.v1`), `schur_degree_one`.

Absolute-value basics (`L0`/`L1`, added to offset the domain's
`L2_olympiad` skew): `abs_add_le`, `abs_add_three`, `abs_sub_le` (metric
triangle inequality), `abs_abs_sub_abs_le` (full doubly-absolute reverse
triangle inequality, strengthening the one-sided `reverse_triangle`).

- [x] `abs_abs_sub_abs_le` — `| |a| - |b| | <= |a - b|` (D0, L0), the full
      reverse triangle inequality. Authored 2026-07-08 via tracked episode
      `e036f4e8-cc8b-4387-96fe-78263bfabd2d` (kernel_verified on the first
      attempt: `abs_cases` on `a`, `b`, `a - b`, and `|a| - |b|` (16
      branches), closed uniformly by `nlinarith`). Strengthens
      `reverse_triangle.v1` (which only proves the one-sided
      `|a| - |b| <= |a - b|`) to the doubly-absolute form.

## Next targets

*(empty — see Backlog.)*

## Backlog

- [ ] General `n`-term AM-GM (L2/L3 — likely needs `InequalityEstimateKit`;
      defer until the 2/3/4-term ladder above is in place).
