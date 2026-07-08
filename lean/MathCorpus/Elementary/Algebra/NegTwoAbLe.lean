import Mathlib
/-!
# Twice a product is at least the negation of the sum of squares

Packet: `elementary.algebra.neg_two_ab_le.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

Twice a product is at least the negation of the sum of squares.
Kernel-verified through the tracked proof-search loop (episode 63772dbe).
-/

namespace MathCorpus.Elementary.Algebra

theorem neg_two_ab_le : ∀ (a b : ℝ), -(a ^ 2 + b ^ 2) ≤ 2 * a * b := by
  intro a b; nlinarith [sq_nonneg (a + b)]

end MathCorpus.Elementary.Algebra
