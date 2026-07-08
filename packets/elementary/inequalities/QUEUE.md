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

## Next targets

- [ ] `bernoulli_inequality` (inequality framing) — see
      `packets/elementary/induction/QUEUE.md` for the induction-proof
      version; if authored here instead, cross-reference the other domain
      in `CROSS_DOMAIN.md` rather than duplicating.
- [ ] `nesbitt_three_var` — `a/(b+c) + b/(a+c) + c/(a+b) >= 3/2` for
      positive `a, b, c` (D2, L2_olympiad). Classic named olympiad
      inequality; natural next step after the existing `three_var_am_gm` /
      `three_var_sq_ge`.
- [ ] `schur_degree_one` — Schur's inequality, `t = 1` case, for
      nonnegative `a, b, c` (D2, L2_olympiad). Pairs well with
      `nesbitt_three_var` as a second named-inequality target.

## Backlog

- [ ] General `n`-term AM-GM (L2/L3 — likely needs `InequalityEstimateKit`;
      defer until the 2/3/4-term ladder above is in place).
