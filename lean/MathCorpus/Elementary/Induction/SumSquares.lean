import Mathlib
open scoped BigOperators

/-!
# Sum of the first n squares

Packet: `elementary.induction.sum_squares.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, six times the sum of the first n squares equals n(n+1)(2n+1).
Kernel-verified through the tracked proof-search loop (episode b5145074).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_squares (n : ℕ) : (∑ i ∈ Finset.range (n + 1), i ^ 2) * 6 = n * (n + 1) * (2 * n + 1) := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, add_mul, ih]
    ring

end MathCorpus.Elementary.Induction
