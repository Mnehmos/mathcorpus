import Mathlib
/-!
# Absolute value of zero

Packet: `elementary.functions.abs_zero.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The absolute value of zero is zero.
Kernel-verified through the tracked proof-search loop (episode 5443bddb).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_zero' : |(0 : ℝ)| = 0 := by
  exact abs_zero

end MathCorpus.Elementary.Functions
