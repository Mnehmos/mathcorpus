import Mathlib
/-!
# Tetrahedral number formula (division-free)

Packet: `elementary.induction.sum_consec_product.v1`
Level:  L1_proof_basics · Domain: induction · Trust rung 1 (Lean kernel).

Three times the sum over k=0..n-1 of (k+1)*(k+2) equals n*(n+1)*(n+2).
Equivalent to the sum of the first n triangular numbers being
n(n+1)(n+2)/6, stated division-free (same doubling/tripling trick as
`arith_seq_sum`).
Kernel-verified through the tracked proof-search loop (episode 1db4baa6).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_consec_product (n : ℕ) :
    3 * (∑ k ∈ Finset.range n, (k + 1) * (k + 2)) = n * (n + 1) * (n + 2) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, Nat.mul_add, ih]
    ring

end MathCorpus.Elementary.Induction
