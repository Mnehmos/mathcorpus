import Mathlib
/-!
# Absolute value is nonnegative

Packet: `elementary.functions.abs_nonneg.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The absolute value of any real is nonnegative.
Kernel-verified through the tracked proof-search loop (episode e2d4f497).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_nonneg' (a : ℝ) : 0 ≤ |a| := by
  exact abs_nonneg a

end MathCorpus.Elementary.Functions
