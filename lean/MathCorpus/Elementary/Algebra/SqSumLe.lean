import Mathlib
/-!
# The square of a sum is bounded by twice the sum of squares

Packet: `elementary.algebra.sq_sum_le.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

The square of a sum is bounded by twice the sum of squares.
Kernel-verified through the tracked proof-search loop (episode 6597db2d).
-/

namespace MathCorpus.Elementary.Algebra

theorem sq_sum_le : ∀ (a b : ℝ), (a + b) ^ 2 ≤ 2 * a ^ 2 + 2 * b ^ 2 := by
  intro a b; nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Algebra
