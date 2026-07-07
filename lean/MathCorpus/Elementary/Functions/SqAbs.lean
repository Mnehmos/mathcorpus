import Mathlib
/-!
# Square of the absolute value

Packet: `elementary.functions.sq_abs.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every real a, |a|^2 = a^2.
Kernel-verified through the tracked proof-search loop (episode df038e4a).
-/

namespace MathCorpus.Elementary.Functions

theorem sq_abs' (a : ℝ) : |a| ^ 2 = a ^ 2 := by
  exact sq_abs a

end MathCorpus.Elementary.Functions
