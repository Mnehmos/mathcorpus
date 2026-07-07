import Mathlib
/-!
# A number times itself is nonnegative

Packet: `elementary.inequalities.mul_self_nonneg.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every real a, 0 ≤ a * a.
Kernel-verified through the tracked proof-search loop (episode e67242f5).
-/

namespace MathCorpus.Elementary.Inequalities

theorem mul_self_nonneg' (a : ℝ) : 0 ≤ a * a := by
  exact mul_self_nonneg a

end MathCorpus.Elementary.Inequalities
