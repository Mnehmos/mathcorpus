import Mathlib
/-!
# Intersection is a subset

Packet: `elementary.combinatorics.inter_subset_left.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

An intersection is contained in its left operand.
Kernel-verified through the tracked proof-search loop (episode a3d8441e).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem inter_subset_left' (s t : Finset ℕ) : s ∩ t ⊆ s := by
  exact Finset.inter_subset_left

end MathCorpus.Elementary.Combinatorics
