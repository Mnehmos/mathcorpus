import Mathlib
/-!
# Less than a successor means at most

Packet: `elementary.number_theory.le_of_lt_succ.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If m < n + 1 then m ≤ n.
Kernel-verified through the tracked proof-search loop (episode 7912bdd3).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem le_of_lt_succ' (m n : ℕ) (h : m < n + 1) : m ≤ n := by
  exact Nat.le_of_lt_succ h

end MathCorpus.Elementary.NumberTheory
