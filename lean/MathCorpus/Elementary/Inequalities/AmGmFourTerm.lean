import Mathlib
/-!
# AM-GM, four-term polynomial special case

Packet: `elementary.inequalities.am_gm_four_term.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c, d: a^4 + b^4 + c^4 + d^4 >= 4*a*b*c*d. A radical-free
polynomial special case of four-term AM-GM (apply AM-GM to a^4, b^4, c^4, d^4),
holding for all reals, not just nonnegative ones.
Kernel-verified through the tracked proof-search loop (episode 26c22232).
-/

namespace MathCorpus.Elementary.Inequalities

theorem am_gm_four_term : ∀ (a b c d : ℝ), a ^ 4 + b ^ 4 + c ^ 4 + d ^ 4 ≥ 4 * a * b * c * d := by
  intro a b c d
  nlinarith [sq_nonneg (a ^ 2 - b ^ 2), sq_nonneg (c ^ 2 - d ^ 2), sq_nonneg (a * b - c * d)]

end MathCorpus.Elementary.Inequalities
