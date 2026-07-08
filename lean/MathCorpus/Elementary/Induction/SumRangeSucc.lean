import Mathlib
open scoped BigOperators

/-!
# Recursion for range sums

Packet: `elementary.induction.sum_range_succ.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

A sum over range (n+1) peels off the last term f n: the recursion underlying inductive sum proofs.
Kernel-verified through the tracked proof-search loop (episode 1dc9ab33).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_range_succ' (f : ℕ → ℕ) (n : ℕ) : (∑ i ∈ Finset.range (n + 1), f i) = (∑ i ∈ Finset.range n, f i) + f n := by
  exact Finset.sum_range_succ f n

end MathCorpus.Elementary.Induction
