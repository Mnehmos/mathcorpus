import Mathlib
/-!
# Sum of the first n positive even numbers is n(n+1)

Packet: `elementary.induction.sum_evens.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, the sum of the first n positive even numbers 2 + 4 + ... + 2n equals n * (n + 1).
Kernel-verified through the tracked proof-search loop (episode 7c564d42).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_evens (n : ℕ) : (∑ i ∈ Finset.range n, (2 * i + 2)) = n * (n + 1) := by
  induction n with
    | zero => simp
    | succ k ih =>
      rw [Finset.sum_range_succ, ih]
      ring

end MathCorpus.Elementary.Induction
