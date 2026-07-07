import Mathlib
open scoped BigOperators

/-!
# Sum over range one

Packet: `elementary.combinatorics.sum_range_one.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

Summing a function over the one-element range {0} gives its value at 0.
Kernel-verified through the tracked proof-search loop (episode 7efc44fe).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem sum_range_one' (f : ℕ → ℕ) : (∑ i ∈ Finset.range 1, f i) = f 0 := by
  simp

end MathCorpus.Elementary.Combinatorics
