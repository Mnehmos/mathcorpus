import Mathlib
/-!
# Truncated subtraction cancels

Packet: `elementary.number_theory.sub_add_cancel.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If n ≤ m then (m - n) + n = m for natural truncated subtraction.
Kernel-verified through the tracked proof-search loop (episode d58aa583).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem sub_add_cancel' (m n : ℕ) (h : n ≤ m) : m - n + n = m := by
  exact Nat.sub_add_cancel h

end MathCorpus.Elementary.NumberTheory
