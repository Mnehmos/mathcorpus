import Mathlib
/-!
# Min is superadditive

Packet: `elementary.inequalities.min_add_min_le.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c, d: min a c + min b d <= min (a+b) (c+d) -- the minimum function is superadditive.
Kernel-verified through the tracked proof-search loop (episode c1fdb760).
-/

namespace MathCorpus.Elementary.Inequalities

theorem min_add_min_le (a b c d : ℝ) : min a c + min b d ≤ min (a + b) (c + d) := by
  apply le_min
  · linarith [min_le_left a c, min_le_left b d]
  · linarith [min_le_right a c, min_le_right b d]

end MathCorpus.Elementary.Inequalities
