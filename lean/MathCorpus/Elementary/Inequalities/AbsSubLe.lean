import Mathlib
/-!
# Triangle inequality for real distance (absolute difference)

Packet: `elementary.inequalities.abs_sub_le.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every triple of real numbers a, b, c: |a - c| <= |a - b| + |b - c|. The
metric-space triangle inequality for real distance, distinct from the additive
abs_add_le/abs_add_three and from reverse_triangle (||a|-|b|| <= |a-b|).
Kernel-verified through the tracked proof-search loop (episode a7e193b6).
-/

namespace MathCorpus.Elementary.Inequalities

theorem abs_sub_le (a b c : ℝ) : |a - c| ≤ |a - b| + |b - c| := by
  rcases abs_cases (a - b) with ⟨h1, h1'⟩ | ⟨h1, h1'⟩ <;>
  rcases abs_cases (b - c) with ⟨h2, h2'⟩ | ⟨h2, h2'⟩ <;>
  rcases abs_cases (a - c) with ⟨h3, h3'⟩ | ⟨h3, h3'⟩ <;>
  linarith

end MathCorpus.Elementary.Inequalities
