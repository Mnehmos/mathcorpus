import Mathlib
/-!
# Sum of a row of Pascal's triangle is a power of two

Packet: `elementary.combinatorics.sum_range_choose.v1`
Level:  L2_olympiad · Domain: combinatorics · Trust rung 1 (Lean kernel).

The sum of all binomial coefficients choose(n,0) + choose(n,1) + ... + choose(n,n) equals 2^n, the total number of subsets of an n-element set.
Kernel-verified through the tracked proof-search loop (episode 11038106).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem sum_range_choose' (n : ℕ) : (∑ m ∈ Finset.range (n + 1), Nat.choose n m) = 2 ^ n := by
  exact Nat.sum_range_choose n

end MathCorpus.Elementary.Combinatorics
