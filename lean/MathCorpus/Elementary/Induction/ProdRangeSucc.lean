import Mathlib
open scoped BigOperators

/-!
# Recursion for range products

Packet: `elementary.induction.prod_range_succ.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

A product over range (n+1) peels off the last factor f n.
Kernel-verified through the tracked proof-search loop (episode ffcacd28).
-/

namespace MathCorpus.Elementary.Induction

theorem prod_range_succ' (f : ℕ → ℕ) (n : ℕ) : (∏ i ∈ Finset.range (n + 1), f i) = (∏ i ∈ Finset.range n, f i) * f n := by
  exact Finset.prod_range_succ f n

end MathCorpus.Elementary.Induction
