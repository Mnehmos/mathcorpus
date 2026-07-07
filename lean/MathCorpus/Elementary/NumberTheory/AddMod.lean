import Mathlib
/-!
# Addition modulo n

Packet: `elementary.number_theory.add_mod.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

A sum modulo n can be reduced summand-wise before taking the final remainder.
Kernel-verified through the tracked proof-search loop (episode 9bba5466).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem add_mod' (a b n : ℕ) : (a + b) % n = (a % n + b % n) % n := by
  exact Nat.add_mod a b n

end MathCorpus.Elementary.NumberTheory
