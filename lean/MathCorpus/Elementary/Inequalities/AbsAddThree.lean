import Mathlib
/-!
# Three-term triangle inequality for real absolute value

Packet: `elementary.inequalities.abs_add_three.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every triple of real numbers a, b, c: |a + b + c| <= |a| + |b| + |c|. Natural
extension of the two-term abs_add_le.
Kernel-verified through the tracked proof-search loop (episode 00c6c1c7).
-/

namespace MathCorpus.Elementary.Inequalities

theorem abs_add_three (a b c : ℝ) : |a + b + c| ≤ |a| + |b| + |c| := by
  rcases abs_cases a with ⟨ha, ha'⟩ | ⟨ha, ha'⟩ <;>
  rcases abs_cases b with ⟨hb, hb'⟩ | ⟨hb, hb'⟩ <;>
  rcases abs_cases c with ⟨hc, hc'⟩ | ⟨hc, hc'⟩ <;>
  rcases abs_cases (a + b + c) with ⟨habc, habc'⟩ | ⟨habc, habc'⟩ <;>
  nlinarith

end MathCorpus.Elementary.Inequalities
