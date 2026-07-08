import Mathlib
/-!
# Telescoping sum identity

Packet: `elementary.induction.telescoping_sum.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every integer-valued sequence a : ℕ -> ℤ and natural number n, the sum of consecutive differences a(i+1) - a(i) over range n telescopes to a(n) - a(0).
Kernel-verified through the tracked proof-search loop (episode 10b7c24b).
-/

namespace MathCorpus.Elementary.Induction

theorem telescoping_sum (a : ℕ → ℤ) (n : ℕ) : (∑ i ∈ Finset.range n, (a (i + 1) - a i)) = a n - a 0 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih]
    ring

end MathCorpus.Elementary.Induction
