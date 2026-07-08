import Mathlib
/-!
# Nesbitt's inequality

Packet: `elementary.inequalities.nesbitt_three_var.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all positive reals a, b, c: a/(b+c) + b/(a+c) + c/(a+b) >= 3/2.
Kernel-verified through the tracked proof-search loop (episode f300e689).
-/

namespace MathCorpus.Elementary.Inequalities

theorem nesbitt_three_var (a b c : ℝ) (ha : a > 0) (hb : b > 0) (hc : c > 0) :
    a / (b + c) + b / (a + c) + c / (a + b) ≥ 3 / 2 := by
  have hbc : b + c > 0 := (by linarith)
  have hac : a + c > 0 := (by linarith)
  have hab : a + b > 0 := (by linarith)
  rw [ge_iff_le, div_add_div _ _ (ne_of_gt hbc) (ne_of_gt hac),
      div_add_div _ _ (mul_ne_zero (ne_of_gt hbc) (ne_of_gt hac)) (ne_of_gt hab),
      le_div_iff₀ (by positivity)]
  nlinarith [sq_nonneg (a-b), sq_nonneg (b-c), sq_nonneg (a-c),
             mul_pos ha hb, mul_pos hb hc, mul_pos ha hc, mul_pos (mul_pos ha hb) hc]

end MathCorpus.Elementary.Inequalities
