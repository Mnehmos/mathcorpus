import Mathlib
/-!
# Cardinality of a union is subadditive

Packet: `elementary.combinatorics.card_union_le.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The number of elements in a union is at most the sum of the sizes.
Kernel-verified through the tracked proof-search loop (episode 2756aadd).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_union_le' (s t : Finset ℕ) : (s ∪ t).card ≤ s.card + t.card := by
  exact Finset.card_union_le s t

end MathCorpus.Elementary.Combinatorics
