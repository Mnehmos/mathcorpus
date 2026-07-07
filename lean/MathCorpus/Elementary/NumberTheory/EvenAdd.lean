import Mathlib
/-!
# Parity of a sum

Packet: `elementary.number_theory.even_add.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

A sum of two naturals is even exactly when the summands have the same parity.
Kernel-verified through the tracked proof-search loop (episode 27d97a1a).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem even_add' (m n : ℕ) : Even (m + n) ↔ (Even m ↔ Even n) := by
  exact Nat.even_add

end MathCorpus.Elementary.NumberTheory
