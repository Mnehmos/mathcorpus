import Mathlib
open scoped BigOperators

/-!
# Gauss sum: twice the sum of 0..n is n(n+1)

Packet: `elementary.induction.gauss_sum.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, twice the sum of 0, 1, ..., n equals n(n+1).
Kernel-verified through the tracked proof-search loop (episode 825f46f5).
-/

namespace MathCorpus.Elementary.Induction

theorem gauss_sum (n : ℕ) : (∑ i ∈ Finset.range (n + 1), i) * 2 = n * (n + 1) := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, add_mul, ih]
    ring

end MathCorpus.Elementary.Induction
