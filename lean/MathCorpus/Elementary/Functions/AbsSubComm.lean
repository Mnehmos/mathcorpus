import Mathlib
/-!
# Absolute value of a difference is symmetric

Packet: `elementary.functions.abs_sub_comm.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a and b, |a - b| = |b - a|.
Kernel-verified through the tracked proof-search loop (episode c74cdf0a).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_sub_comm' (a b : ℝ) : |a - b| = |b - a| := by
  exact abs_sub_comm a b

end MathCorpus.Elementary.Functions
