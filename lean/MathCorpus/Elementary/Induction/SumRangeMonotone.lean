import Mathlib
open scoped BigOperators

/-!
# Partial sums of a nonnegative-valued sequence are monotone

Packet: `elementary.induction.sum_range_monotone.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every function f : ℕ → ℕ and natural numbers n, k, the partial sum over
`range n` is at most the partial sum over `range (n + k)` — finite partial
sums of a nonnegative-valued sequence are monotone in the upper bound.
Proved by induction on k, reusing `Finset.sum_range_succ` in the style of
`sum_odds` / `sum_evens` / `geom_series_sum_induction`.
Kernel-verified through the tracked proof-search loop (episode 3280a193).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_range_monotone (f : ℕ → ℕ) (n k : ℕ) :
    (∑ i ∈ Finset.range n, f i) ≤ ∑ i ∈ Finset.range (n + k), f i := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [show n + (k + 1) = (n + k) + 1 from rfl, Finset.sum_range_succ]
    exact le_trans ih (Nat.le_add_right _ _)

end MathCorpus.Elementary.Induction
