import Mathlib
/-!
# Product of consecutive integers is even

Packet: `elementary.number_theory.even_mul_succ_self.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

For every integer n, the product n * (n + 1) of two consecutive integers is even.
Kernel-verified through the tracked proof-search loop (episode 2d03654d).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem even_mul_succ_self (n : ℤ) : Even (n * (n + 1)) := by
  exact Int.even_mul_succ_self n

end MathCorpus.Elementary.NumberTheory
