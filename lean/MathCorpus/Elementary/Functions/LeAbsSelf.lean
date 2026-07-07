import Mathlib
/-!
# A number is at most its absolute value

Packet: `elementary.functions.le_abs_self.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Every real is at most its own absolute value.
Kernel-verified through the tracked proof-search loop (episode 2f198825).
-/

namespace MathCorpus.Elementary.Functions

theorem le_abs_self' (a : ℝ) : a ≤ |a| := by
  exact le_abs_self a

end MathCorpus.Elementary.Functions
