import Mathlib
/-!
# Subset of a union

Packet: `elementary.combinatorics.subset_union_left.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

A finite set is contained in its union with any other set.
Kernel-verified through the tracked proof-search loop (episode 5ebf7be9).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem subset_union_left' (s t : Finset ℕ) : s ⊆ s ∪ t := by
  exact Finset.subset_union_left

end MathCorpus.Elementary.Combinatorics
