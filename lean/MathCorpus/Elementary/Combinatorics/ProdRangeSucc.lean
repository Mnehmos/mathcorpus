import Mathlib
/-!
# Splitting off the last factor of a finite product

Packet: `elementary.combinatorics.prod_range_succ.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The product over range (n+1) splits off its last factor: the product of f over {0,...,n} equals the product over {0,...,n-1} times f(n).
Kernel-verified through the tracked proof-search loop (episode dc35fd64).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem prod_range_succ' (f : ℕ → ℕ) (n : ℕ) : ∏ i ∈ Finset.range (n + 1), f i = (∏ i ∈ Finset.range n, f i) * f n := by
  exact Finset.prod_range_succ f n

end MathCorpus.Elementary.Combinatorics
