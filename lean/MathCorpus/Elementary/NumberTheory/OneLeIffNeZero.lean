import Mathlib
/-!
# At least one iff nonzero

Packet: `elementary.number_theory.one_le_iff_ne_zero.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

A natural number is at least one exactly when it is nonzero.
Kernel-verified through the tracked proof-search loop (episode 1df983bc).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem one_le_iff_ne_zero' (n : ℕ) : 1 ≤ n ↔ n ≠ 0 := by
  exact Nat.one_le_iff_ne_zero

end MathCorpus.Elementary.NumberTheory
