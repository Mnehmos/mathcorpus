import Mathlib
open scoped BigOperators

/-!
# Sum of the first n odd numbers is n squared

Packet: `elementary.induction.sum_odds.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, the sum of the first n odd numbers 1 + 3 + ... + (2n-1) equals n^2.
Kernel-verified through the tracked proof-search loop (episode 939139c6).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_odds (n : ℕ) : (∑ i ∈ Finset.range n, (2 * i + 1)) = n ^ 2 := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, ih]
    ring

end MathCorpus.Elementary.Induction
