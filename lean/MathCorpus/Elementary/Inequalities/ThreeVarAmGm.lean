import Mathlib
/-!
# 3(ab+bc+ca) ≤ (a+b+c)²

Packet: `elementary.inequalities.three_var_am_gm.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c: 3(ab+bc+ca) ≤ (a+b+c)².
Kernel-verified through the tracked proof-search loop (episode f04ee69b).
-/

namespace MathCorpus.Elementary.Inequalities

theorem three_var_am_gm (a b c : ℝ) : 3 * (a * b + b * c + c * a) ≤ (a + b + c) ^ 2 := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (c - a)]

end MathCorpus.Elementary.Inequalities
