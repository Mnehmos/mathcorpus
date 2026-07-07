import Mathlib
/-!
# Factorial is positive

Packet: `elementary.number_theory.factorial_pos.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

The factorial of any natural number is positive.
Kernel-verified through the tracked proof-search loop (episode 53b01247).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem factorial_pos' (n : ℕ) : 0 < Nat.factorial n := by
  exact Nat.factorial_pos n

end MathCorpus.Elementary.NumberTheory
