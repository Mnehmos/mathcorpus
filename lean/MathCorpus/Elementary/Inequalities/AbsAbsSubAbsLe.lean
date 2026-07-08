import Mathlib
/-!
# Full (doubly-absolute) reverse triangle inequality

Packet: `elementary.inequalities.abs_abs_sub_abs_le.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every pair of real numbers a, b: the absolute value of |a| - |b| is at most |a - b| -- the full (doubly-absolute) reverse triangle inequality, strengthening the domain's existing one-sided reverse_triangle.v1 (|a| - |b| <= |a - b|) by also bounding the case |b| - |a| > 0.
Kernel-verified through the tracked proof-search loop (episode e036f4e8).
-/

namespace MathCorpus.Elementary.Inequalities

theorem abs_abs_sub_abs_le (a b : ℝ) : |(|a| - |b|)| ≤ |a - b| := by
  rcases abs_cases a with ⟨ha, ha'⟩ | ⟨ha, ha'⟩ <;>
  rcases abs_cases b with ⟨hb, hb'⟩ | ⟨hb, hb'⟩ <;>
  rcases abs_cases (a - b) with ⟨hab, hab'⟩ | ⟨hab, hab'⟩ <;>
  rcases abs_cases (|a| - |b|) with ⟨hd, hd'⟩ | ⟨hd, hd'⟩ <;>
  nlinarith [ha, ha', hb, hb', hab, hab', hd, hd']

end MathCorpus.Elementary.Inequalities
