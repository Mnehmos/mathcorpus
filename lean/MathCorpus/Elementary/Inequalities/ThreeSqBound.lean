import Mathlib
/-!
# (a+b+c)² ≤ 3(a²+b²+c²)

Packet: `elementary.inequalities.three_sq_bound.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c: (a+b+c)² ≤ 3(a²+b²+c²) (a power-mean bound).
Kernel-verified through the tracked proof-search loop (episode 727a02b0).
-/

namespace MathCorpus.Elementary.Inequalities

theorem three_sq_bound (a b c : ℝ) : (a + b + c) ^ 2 ≤ 3 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (c - a)]

end MathCorpus.Elementary.Inequalities
