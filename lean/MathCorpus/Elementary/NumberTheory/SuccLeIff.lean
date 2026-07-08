import Mathlib
/-!
# m+1 ≤ n exactly when m < n

Packet: `elementary.number_theory.succ_le_iff.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

m+1 ≤ n exactly when m < n.
Kernel-verified through the tracked proof-search loop (episode b630bc01).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem succ_le_iff : ∀ (m n : ℕ), m + 1 ≤ n ↔ m < n := by
  intro m n; exact Nat.succ_le_iff

end MathCorpus.Elementary.NumberTheory
