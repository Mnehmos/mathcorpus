import Mathlib
/-!
# 4ab ≤ (a+b)²

Packet: `elementary.inequalities.four_mul_le_add_sq.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a and b, 4ab ≤ (a+b)².
Kernel-verified through the tracked proof-search loop (episode 91aeab01).
-/

namespace MathCorpus.Elementary.Inequalities

theorem four_mul_le_add_sq (a b : ℝ) : 4 * a * b ≤ (a + b) ^ 2 := by
  nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Inequalities
