import Mathlib
/-!
# For every real x, 2x^2 ≤ x^4 + 1

Packet: `elementary.algebra.x4_ge_2x2.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For every real x, 2x^2 ≤ x^4 + 1.
Kernel-verified through the tracked proof-search loop (episode d55826c4).
-/

namespace MathCorpus.Elementary.Algebra

theorem x4_ge_2x2 : ∀ (x : ℝ), 2 * x ^ 2 ≤ x ^ 4 + 1 := by
  intro x; nlinarith [sq_nonneg (x ^ 2 - 1)]

end MathCorpus.Elementary.Algebra
