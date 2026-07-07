import Mathlib
/-!
# A real square is nonnegative

Packet: `elementary.inequalities.sq_nonneg.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every real number a, 0 ≤ a^2.
Kernel-verified through the tracked proof-search loop (episode 58679241).
-/

namespace MathCorpus.Elementary.Inequalities

theorem sq_nonneg' (a : ℝ) : 0 ≤ a ^ 2 := by
  exact sq_nonneg a

end MathCorpus.Elementary.Inequalities
