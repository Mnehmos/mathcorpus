import Mathlib
open scoped BigOperators

/-!
# Geometric series closed form, proved by induction

Packet: `elementary.induction.geom_series_sum_induction.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every integer r and natural number n, the geometric series sum
1 + r + r^2 + ... + r^(n-1), multiplied by (r - 1), equals r^n - 1. Proved
by induction on n — a distinct proof style from the factorization-based
`packets/elementary/functions/geom_series_mul` packet.
Kernel-verified through the tracked proof-search loop (episode f99a1298).
-/

namespace MathCorpus.Elementary.Induction

theorem geom_series_sum_induction (r : ℤ) (n : ℕ) :
    (∑ i ∈ Finset.range n, r ^ i) * (r - 1) = r ^ n - 1 := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, add_mul, ih]
    ring

end MathCorpus.Elementary.Induction
