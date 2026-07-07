import Mathlib
/-!
# Factorial is monotone

Packet: `elementary.number_theory.factorial_le.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If m ≤ n then m! ≤ n!.
Kernel-verified through the tracked proof-search loop (episode 466dd6e8).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem factorial_le' (m n : ℕ) (h : m ≤ n) : Nat.factorial m ≤ Nat.factorial n := by
  exact Nat.factorial_le h

end MathCorpus.Elementary.NumberTheory
