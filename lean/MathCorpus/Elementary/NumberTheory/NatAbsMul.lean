import Mathlib
/-!
# Natural absolute value is multiplicative

Packet: `elementary.number_theory.nat_abs_mul.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

The natural absolute value of a product is the product of the natural absolute values.
Kernel-verified through the tracked proof-search loop (episode 7b2cf0c4).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem natAbs_mul' (a b : ℤ) : (a * b).natAbs = a.natAbs * b.natAbs := by
  exact Int.natAbs_mul a b

end MathCorpus.Elementary.NumberTheory
