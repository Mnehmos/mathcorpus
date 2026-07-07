import Mathlib
/-!
# Minimum with itself

Packet: `elementary.functions.min_self.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The minimum of a number with itself is the number.
Kernel-verified through the tracked proof-search loop (episode f5180a9c).
-/

namespace MathCorpus.Elementary.Functions

theorem min_self' (a : ℝ) : min a a = a := by
  exact min_self a

end MathCorpus.Elementary.Functions
