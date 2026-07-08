import Mathlib
/-!
# a^2 + b^2 ≥ 2ab

Packet: `elementary.algebra.sq_sum_ge_two_mul.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b: a^2 + b^2 ≥ 2ab, equivalent to (a - b)^2 ≥ 0.
Kernel-verified through the tracked proof-search loop (episode 42da9f6e).
Paired negative example:
`negative.algebra.sq_sum_bare_nlinarith.missing_sos_hint.v1` (bare
`nlinarith` fails without the `sq_nonneg (a - b)` hint).
-/

namespace MathCorpus.Elementary.Algebra

theorem sq_sum_ge_two_mul (a b : ℝ) : a ^ 2 + b ^ 2 ≥ 2 * a * b := by
  nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Algebra
