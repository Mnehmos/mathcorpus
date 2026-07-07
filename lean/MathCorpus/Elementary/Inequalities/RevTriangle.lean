import Mathlib
/-!
# Reverse triangle inequality

Packet: `elementary.inequalities.reverse_triangle.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a and b, |a| - |b| ≤ |a - b|.
Kernel-verified through the tracked proof-search loop (episode 237d82d5).
-/

namespace MathCorpus.Elementary.Inequalities

theorem abs_sub_abs_le_abs_sub' (a b : ℝ) : |a| - |b| ≤ |a - b| := by
  exact abs_sub_abs_le_abs_sub a b

end MathCorpus.Elementary.Inequalities
