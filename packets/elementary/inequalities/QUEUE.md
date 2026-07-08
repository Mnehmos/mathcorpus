# Queue — Inequalities (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 16 existing packets (2026-07-07) to avoid duplicates.

## Done

- [x] `am_gm_four_term` — `a^4+b^4+c^4+d^4 >= 4*a*b*c*d` for all reals
      (D2, L2_olympiad). Authored 2026-07-08 via tracked episode
      `26c22232-4518-4edc-9c11-b63813cf670f` (kernel_verified on the first
      attempt: `nlinarith [sq_nonneg (a^2 - b^2), sq_nonneg (c^2 - d^2),
      sq_nonneg (a*b - c*d)]`). Deliberately phrased as the radical-free
      polynomial special case (fourth powers) rather than the classical
      `(a+b+c+d)/4 >= (abcd)^(1/4)` form, which needs `Real.sqrt`/`rpow`
      machinery not attempted this cycle. Completes the AM-GM ladder
      alongside `am_gm_two` and `three_var_am_gm`.

## Done

- [x] `nesbitt_three_var` — `a/(b+c) + b/(a+c) + c/(a+b) >= 3/2` for
      positive `a, b, c` (D2, L2_olympiad). Authored 2026-07-08 via tracked
      episode `f300e689-9670-45f4-8454-47e4e80b73ac` (kernel_verified:
      clear denominators via `div_add_div` ×2 + `le_div_iff₀`, then
      `nlinarith` with the three pairwise-square hints and positivity of
      the pairwise products). A bare-`nlinarith`-on-the-raw-division-goal
      attempt kernel-failed first in the same episode and is preserved as
      `packets/negative/inequalities/nesbitt_bare_nlinarith_division_failure.v1.json`.
      (Note: `bernoulli_inequality` was independently claimed and landed on
      the `packets/elementary/induction/` side — see that domain's
      `QUEUE.md` — so it is removed from here rather than duplicated.)

## Next targets

- [ ] `schur_degree_one` — Schur's inequality, `t = 1` case, for
      nonnegative `a, b, c` (D2, L2_olympiad). Pairs well with
      `nesbitt_three_var` (done above) as a second named-inequality target.

## Backlog

- [ ] General `n`-term AM-GM (L2/L3 — likely needs `InequalityEstimateKit`;
      defer until the 2/3/4-term ladder above is in place).
