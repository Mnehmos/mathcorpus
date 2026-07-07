import Mathlib
/-!
# Intersection subset of the right operand

Packet: `elementary.combinatorics.inter_subset_right.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

An intersection is contained in its right operand.
Kernel-verified through the tracked proof-search loop (episode 3aaa23e2).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem inter_subset_right' (s t : Finset ℕ) : s ∩ t ⊆ t := by
  exact Finset.inter_subset_right

end MathCorpus.Elementary.Combinatorics
