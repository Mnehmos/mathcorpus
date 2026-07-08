# Queue — Inequalities (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~6/25 corpus-wide as of 2026-07-08) — prioritize this lane highly.
Candidates below are hypotheses to verify via a real tracked episode, not
pre-asserted facts.

## Next targets

- [ ] AM-GM in the wrong direction: an attempt that mixes up which side of
      AM-GM is larger (e.g. tries `(a+b)/2 <= Real.sqrt (a*b)` instead of
      `>=`) and gets a genuine kernel rejection — captures a
      direction/sign-flip mistake rather than a tactic-strength mistake.
- [ ] `linarith` (not `nlinarith`) attempted on a genuinely nonlinear
      inequality (product term present) — captures "wrong automation
      tactic entirely" vs. this lane's existing "right tactic, missing
      hints" examples.
- [ ] `polyrith`/`nlinarith` degree-mismatch: an inequality whose SOS
      certificate needs degree-4 terms that `nlinarith`'s default search
      depth doesn't reach (verify a concrete instance before adding).

## Backlog

- [ ]

## Completed

- [x] **nlinarith without hints on a three-variable symmetric inequality.**
      `three_var_sq_bare_nlinarith_failure.v1.json` — bare `nlinarith` on
      `a^2+b^2+c^2 >= a*b+b*c+c*a` fails (`kernel_fail`, "linarith failed to
      find a contradiction"); `nlinarith [sq_nonneg (a-b), sq_nonneg (b-c),
      sq_nonneg (a-c)]` closes the same tracked episode `kernel_verified`.
      episode `d1e875d2-1cef-45c1-a76e-d46e84f67aa9`.
- [x] **bare nlinarith on Nesbitt's inequality without clearing
      denominators.** `nesbitt_bare_nlinarith_division_failure.v1.json` —
      `nlinarith` with square/positivity hints on the raw division goal
      `a/(b+c)+b/(a+c)+c/(a+b) >= 3/2` fails (`kernel_fail`, "linarith
      failed to find a contradiction"); clearing denominators
      (`div_add_div` ×2 + `le_div_iff₀`) then the same `nlinarith` hints
      closes the same tracked episode `kernel_verified` as
      `packets/elementary/inequalities/nesbitt_three_var.v1.json`. episode
      `f300e689-9670-45f4-8454-47e4e80b73ac`.
