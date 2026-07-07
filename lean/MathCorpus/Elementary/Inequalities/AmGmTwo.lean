import Mathlib
/-!
# AM-GM for two reals (mean-square form)

Packet: `elementary.inequalities.am_gm_two.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a and b, the product ab is at most the square of the arithmetic mean.
Kernel-verified through the tracked proof-search loop (episode a9e3626a).
-/

namespace MathCorpus.Elementary.Inequalities

theorem am_gm_two (a b : ℝ) : a * b ≤ ((a + b) / 2) ^ 2 := by
  nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Inequalities
