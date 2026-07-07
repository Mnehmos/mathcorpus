import Mathlib
/-!
# Absolute value is multiplicative

Packet: `elementary.functions.abs_mul.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all real a and b, |a * b| = |a| * |b|.
Kernel-verified through the tracked proof-search loop (episode 88819729).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_mul' (a b : ℝ) : |a * b| = |a| * |b| := by
  exact abs_mul a b

end MathCorpus.Elementary.Functions
