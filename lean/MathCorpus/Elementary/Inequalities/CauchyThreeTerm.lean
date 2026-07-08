import Mathlib
/-!
# Cauchy-Schwarz inequality, three-term case

Packet: `elementary.inequalities.cauchy_three_term.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c, x, y, z: (a*x + b*y + c*z)^2 <= (a^2+b^2+c^2)*(x^2+y^2+z^2) -- the three-term Cauchy-Schwarz inequality.
Kernel-verified through the tracked proof-search loop (episode 3e12e9cc).
-/

namespace MathCorpus.Elementary.Inequalities

theorem cauchy_three_term (a b c x y z : ℝ) : (a * x + b * y + c * z) ^ 2 ≤ (a ^ 2 + b ^ 2 + c ^ 2) * (x ^ 2 + y ^ 2 + z ^ 2) := by
  nlinarith [sq_nonneg (a * y - b * x), sq_nonneg (a * z - c * x), sq_nonneg (b * z - c * y)]

end MathCorpus.Elementary.Inequalities
