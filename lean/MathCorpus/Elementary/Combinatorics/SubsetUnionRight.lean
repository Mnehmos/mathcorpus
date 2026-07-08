import Mathlib
/-!
# Right operand is a subset of the union

Packet: `elementary.combinatorics.subset_union_right.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The right operand of a union is contained in the union.
Kernel-verified through the tracked proof-search loop (episode 91481a8e).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem subset_union_right' (s t : Finset ℕ) : t ⊆ s ∪ t := by
  exact Finset.subset_union_right

end MathCorpus.Elementary.Combinatorics
