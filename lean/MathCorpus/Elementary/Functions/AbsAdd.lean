import Mathlib
/-!
# Triangle inequality for real absolute value

Packet: `elementary.functions.abs_add_le.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all real a and b, |a + b| ≤ |a| + |b|.
Kernel-verified through the tracked proof-search loop (episode 284ea4dc).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_add_le' (a b : ℝ) : |a + b| ≤ |a| + |b| := by
  exact abs_add_le a b

end MathCorpus.Elementary.Functions
