import Mathlib
/-!
# Two-term Cauchy-Schwarz

Packet: `elementary.inequalities.cauchy_two_term.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c, d: (ac + bd)^2 ≤ (a^2 + b^2)(c^2 + d^2).
Kernel-verified through the tracked proof-search loop (episode fec2a36c).
-/

namespace MathCorpus.Elementary.Inequalities

theorem cauchy_two_term (a b c d : ℝ) : (a * c + b * d) ^ 2 ≤ (a ^ 2 + b ^ 2) * (c ^ 2 + d ^ 2) := by
  nlinarith [sq_nonneg (a * d - b * c)]

end MathCorpus.Elementary.Inequalities
