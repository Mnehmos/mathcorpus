import Mathlib
/-!
# Multiplication modulo n

Packet: `elementary.number_theory.mul_mod.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

A product modulo n can be reduced factor-wise before taking the final remainder.
Kernel-verified through the tracked proof-search loop (episode c43e2c46).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem mul_mod' (a b n : ℕ) : a * b % n = a % n * (b % n) % n := by
  exact Nat.mul_mod a b n

end MathCorpus.Elementary.NumberTheory
