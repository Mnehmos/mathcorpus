import Mathlib
/-!
# gcd times lcm equals the product

Packet: `elementary.number_theory.gcd_mul_lcm.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

The classic identity tying gcd and lcm together: Nat.gcd a b * Nat.lcm a b = a * b.
Kernel-verified through the tracked proof-search loop (episode f6352ddf).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_mul_lcm (a b : ℕ) : Nat.gcd a b * Nat.lcm a b = a * b := by
  exact Nat.gcd_mul_lcm a b

end MathCorpus.Elementary.NumberTheory
