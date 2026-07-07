import Mathlib
/-!
# QM-AM bound (a+b)² ≤ 2(a²+b²)

Packet: `elementary.inequalities.qm_am_bound.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a and b, (a+b)² ≤ 2(a²+b²) (a QM-AM / power-mean bound).
Kernel-verified through the tracked proof-search loop (episode dd10b5d2).
-/

namespace MathCorpus.Elementary.Inequalities

theorem qm_am_bound (a b : ℝ) : (a + b) ^ 2 ≤ 2 * (a ^ 2 + b ^ 2) := by
  nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Inequalities
