import Mathlib
/-!
# General arithmetic-sequence sum formula

Packet: `elementary.induction.arith_seq_sum.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For an arithmetic sequence starting at a with common difference d, twice the sum of the first n terms equals n * (2a + (n-1)*d) -- the general arithmetic-series formula.
Kernel-verified through the tracked proof-search loop (episode b6ef7a97).
-/

namespace MathCorpus.Elementary.Induction

theorem arith_seq_sum (a d : ℤ) (n : ℕ) : (∑ i ∈ Finset.range n, (a + (i : ℤ) * d)) * 2 = (n : ℤ) * (2 * a + ((n : ℤ) - 1) * d) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, add_mul, ih]
    push_cast
    ring

end MathCorpus.Elementary.Induction
