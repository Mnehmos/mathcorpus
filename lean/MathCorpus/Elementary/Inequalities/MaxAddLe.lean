import Mathlib
/-!
# Max is subadditive

Packet: `elementary.inequalities.max_add_le.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c, d: max (a+b) (c+d) <= max a c + max b d -- the maximum function is subadditive.
Kernel-verified through the tracked proof-search loop (episode a6eb2a43).
-/

namespace MathCorpus.Elementary.Inequalities

theorem max_add_le (a b c d : ℝ) : max (a + b) (c + d) ≤ max a c + max b d := by
  apply max_le
  · linarith [le_max_left a c, le_max_left b d]
  · linarith [le_max_right a c, le_max_right b d]

end MathCorpus.Elementary.Inequalities
