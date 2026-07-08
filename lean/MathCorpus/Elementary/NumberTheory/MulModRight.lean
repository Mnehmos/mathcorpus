import Mathlib
/-!
# A multiple of a is divisible by a

Packet: `elementary.number_theory.mul_mod_right.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

A multiple of a is divisible by a.
Kernel-verified through the tracked proof-search loop (episode da2c1a1c).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem mul_mod_right : ∀ (a b : ℕ), a * b % a = 0 := by
  intro a b; exact Nat.mul_mod_right a b

end MathCorpus.Elementary.NumberTheory
