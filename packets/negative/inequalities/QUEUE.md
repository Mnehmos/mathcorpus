# Queue — Inequalities (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~6/25 corpus-wide as of 2026-07-08) — prioritize this lane highly.
Candidates below are hypotheses to verify via a real tracked episode, not
pre-asserted facts.

## Next targets

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
- [x] **bare `linarith` (not `nlinarith`) on a nonlinear inequality.**
      `two_mul_le_add_sq_bare_linarith_failure.v1.json` — `linarith` on
      `2*a*b <= a^2+b^2` fails outright (`kernel_fail`, "linarith failed to
      find a contradiction") since it never multiplies hypotheses/squares
      terms at all; `nlinarith [sq_nonneg (a - b)]` closes the same tracked
      episode `kernel_verified`. episode
      `8cbd4eff-8a4a-4c80-b0bb-49cfa0c7e181`. A distinct, more basic
      failure class than this lane's other examples: wrong tactic
      entirely, not merely missing hints.
- [x] **AM-GM in the wrong direction (false_generalization).**
      `amgm_wrong_direction_bare_nlinarith_failure.v1.json` — `nlinarith`
      with the correct-direction hint set on the flipped claim `(a+b)/2
      <= sqrt(a*b)` fails (`kernel_fail`, "linarith failed to find a
      contradiction") because the claim is genuinely false, not merely
      under-hinted; closed with `give_up`. episode
      `ade3dee6-5a63-4a59-bf1a-0ec4e86c89aa`. Falseness kernel-verified
      separately via witness `a=1, b=9` in the companion positive packet
      `elementary.inequalities.amgm_wrong_direction_counterexample.v1`
      (episode `5c239fdd-ef5b-440d-b070-16de9d7d95c0`). This lane's first
      `false_generalization`-category example (prior examples here were
      `tactic_mismatch` on true statements).
