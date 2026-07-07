import Mathlib
/-!
# ab + bc + ca ≤ a² + b² + c²

Packet: `elementary.inequalities.three_var_sq_ge.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all real a, b, c: ab + bc + ca ≤ a² + b² + c².
Kernel-verified through the tracked proof-search loop (episode 2d093daf).
-/

namespace MathCorpus.Elementary.Inequalities

theorem three_var_sq_ge (a b c : ℝ) : a * b + b * c + c * a ≤ a ^ 2 + b ^ 2 + c ^ 2 := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (c - a)]

end MathCorpus.Elementary.Inequalities
