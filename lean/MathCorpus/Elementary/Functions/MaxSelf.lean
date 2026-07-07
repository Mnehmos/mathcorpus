import Mathlib
/-!
# Maximum with itself

Packet: `elementary.functions.max_self.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The maximum of a number with itself is the number.
Kernel-verified through the tracked proof-search loop (episode de1b9e3f).
-/

namespace MathCorpus.Elementary.Functions

theorem max_self' (a : ℝ) : max a a = a := by
  exact max_self a

end MathCorpus.Elementary.Functions
