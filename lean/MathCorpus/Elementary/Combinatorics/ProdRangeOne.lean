import Mathlib
open scoped BigOperators

/-!
# Product over range one

Packet: `elementary.combinatorics.prod_range_one.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

A product over the one-element range {0} equals the value at 0.
Kernel-verified through the tracked proof-search loop (episode f7dfbab8).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem prod_range_one' (f : ℕ → ℕ) : (∏ i ∈ Finset.range 1, f i) = f 0 := by
  simp

end MathCorpus.Elementary.Combinatorics
