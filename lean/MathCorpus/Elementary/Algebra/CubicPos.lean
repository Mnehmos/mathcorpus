import Mathlib
/-!
# The quadratic a^2+a+1 is always positive

Packet: `elementary.algebra.cubic_pos.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

The quadratic a^2+a+1 is always positive.
Kernel-verified through the tracked proof-search loop (episode eb0c2e12).
-/

namespace MathCorpus.Elementary.Algebra

theorem cubic_pos : ∀ (a : ℝ), 0 < a ^ 2 + a + 1 := by
  intro a; nlinarith [sq_nonneg (2 * a + 1)]

end MathCorpus.Elementary.Algebra
