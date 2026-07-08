# Queue — Inequalities (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 16 existing packets (2026-07-07) to avoid duplicates.

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
- [ ] `am_gm_four_term` — four-variable AM-GM special case (D1/D2, L1/L2).
      The domain has the two-term (`am_gm_two`) and three-term
      (`three_var_am_gm`) cases; four terms is the natural next rung before
      attempting a general-`n` statement.

## Backlog

- [ ] General `n`-term AM-GM (L2/L3 — likely needs `InequalityEstimateKit`;
      defer until the 2/3/4-term ladder above is in place).
