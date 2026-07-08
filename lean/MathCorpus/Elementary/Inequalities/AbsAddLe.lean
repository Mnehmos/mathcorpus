import Mathlib
/-!
# Triangle inequality for real absolute value

Packet: `elementary.inequalities.abs_add_le.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every pair of real numbers a, b, the absolute value of a + b is at most |a| + |b| (the triangle inequality for real absolute value).
Kernel-verified through the tracked proof-search loop (episode 0c084674).
-/

namespace MathCorpus.Elementary.Inequalities

theorem abs_add_le (a b : ℝ) : |a + b| ≤ |a| + |b| := by
  rcases abs_cases a with ⟨ha, ha'⟩ | ⟨ha, ha'⟩ <;>
  rcases abs_cases b with ⟨hb, hb'⟩ | ⟨hb, hb'⟩ <;>
  rcases abs_cases (a + b) with ⟨hab, hab'⟩ | ⟨hab, hab'⟩ <;>
  nlinarith

end MathCorpus.Elementary.Inequalities
