import Mathlib
/-!
# Negated absolute value is a lower bound

Packet: `elementary.functions.neg_abs_le.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

The negation of the absolute value is a lower bound for the number.
Kernel-verified through the tracked proof-search loop (episode 303c4396).
-/

namespace MathCorpus.Elementary.Functions

theorem neg_abs_le' (a : ℝ) : -|a| ≤ a := by
  exact neg_abs_le a

end MathCorpus.Elementary.Functions
