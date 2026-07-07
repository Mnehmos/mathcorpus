import Mathlib
/-!
# 2a²b² ≤ a⁴ + b⁴

Packet: `elementary.inequalities.two_sq_prod_le.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a and b, 2a²b² ≤ a⁴ + b⁴.
Kernel-verified through the tracked proof-search loop (episode 6d18827c).
-/

namespace MathCorpus.Elementary.Inequalities

theorem two_sq_prod_le (a b : ℝ) : 2 * a ^ 2 * b ^ 2 ≤ a ^ 4 + b ^ 4 := by
  nlinarith [sq_nonneg (a ^ 2 - b ^ 2)]

end MathCorpus.Elementary.Inequalities
