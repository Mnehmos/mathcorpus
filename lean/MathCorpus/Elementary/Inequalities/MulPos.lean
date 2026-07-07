import Mathlib
/-!
# Product of positives is positive

Packet: `elementary.inequalities.mul_pos.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

The product of two positive reals is positive.
Kernel-verified through the tracked proof-search loop (episode e5e47652).
-/

namespace MathCorpus.Elementary.Inequalities

theorem mul_pos' (a b : ℝ) (ha : 0 < a) (hb : 0 < b) : 0 < a * b := by
  exact mul_pos ha hb

end MathCorpus.Elementary.Inequalities
