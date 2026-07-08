import Mathlib
/-!
# 2a ≤ a² + 1

Packet: `elementary.inequalities.two_a_le_sq_add_one.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For every real a, 2a ≤ a² + 1.
Kernel-verified through the tracked proof-search loop (episode 57f58933).
-/

namespace MathCorpus.Elementary.Inequalities

theorem two_a_le_sq_add_one (a : ℝ) : 2 * a ≤ a ^ 2 + 1 := by
  nlinarith [sq_nonneg (a - 1)]

end MathCorpus.Elementary.Inequalities
