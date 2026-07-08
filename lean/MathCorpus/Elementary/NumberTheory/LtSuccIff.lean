import Mathlib
/-!
# m < n+1 exactly when m ≤ n

Packet: `elementary.number_theory.lt_succ_iff.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

m < n+1 exactly when m ≤ n.
Kernel-verified through the tracked proof-search loop (episode 02dcd779).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem lt_succ_iff : ∀ (m n : ℕ), m < n + 1 ↔ m ≤ n := by
  intro m n; exact Nat.lt_succ_iff

end MathCorpus.Elementary.NumberTheory
