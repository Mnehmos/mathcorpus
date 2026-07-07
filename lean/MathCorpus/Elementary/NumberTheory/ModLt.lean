import Mathlib
/-!
# Remainder is less than a positive modulus

Packet: `elementary.number_theory.mod_lt.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

For naturals a and b with b > 0, a mod b < b.
Kernel-verified through the tracked proof-search loop (episode e5b5b446).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem mod_lt' (a b : ℕ) (h : 0 < b) : a % b < b := by
  exact Nat.mod_lt a h

end MathCorpus.Elementary.NumberTheory
