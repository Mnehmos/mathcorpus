import Mathlib
/-!
# x² - x + 1 is always positive

Packet: `elementary.inequalities.quad_pos.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

The quadratic x² - x + 1 is strictly positive for every real x (negative discriminant).
Kernel-verified through the tracked proof-search loop (episode cff308a5).
-/

namespace MathCorpus.Elementary.Inequalities

theorem quad_pos (x : ℝ) : 0 < x ^ 2 - x + 1 := by
  nlinarith [sq_nonneg (2 * x - 1)]

end MathCorpus.Elementary.Inequalities
