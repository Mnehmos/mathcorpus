import Mathlib
/-!
# x + 1/x ≥ 2 for positive x

Packet: `elementary.inequalities.add_one_div_ge_two.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For every positive real x, x + 1/x ≥ 2.
Kernel-verified through the tracked proof-search loop (episode 81427648).
-/

namespace MathCorpus.Elementary.Inequalities

theorem add_one_div_ge_two (x : ℝ) (hx : 0 < x) : 2 ≤ x + 1 / x := by
  have hx0 : x ≠ 0 := ne_of_gt hx
  rw [← sub_nonneg]
  have key : x + 1 / x - 2 = (x - 1) ^ 2 / x := by
    field_simp
    ring
  rw [key]
  positivity

end MathCorpus.Elementary.Inequalities
