import Mathlib
/-!
# Absolute value of a nonnegative

Packet: `elementary.functions.abs_of_nonneg.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

The absolute value of a nonnegative real equals the real.
Kernel-verified through the tracked proof-search loop (episode 7a2a4659).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_of_nonneg' (a : ℝ) (h : 0 ≤ a) : |a| = a := by
  exact abs_of_nonneg h

end MathCorpus.Elementary.Functions
