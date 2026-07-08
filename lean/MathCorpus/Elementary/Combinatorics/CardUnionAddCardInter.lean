import Mathlib
/-!
# Inclusion-exclusion for finite set cardinality

Packet: `elementary.combinatorics.card_union_add_card_inter.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The number of elements in the union plus the number of elements in the intersection equals the sum of the two set sizes (inclusion-exclusion for cardinality).
Kernel-verified through the tracked proof-search loop (episode 23c3ba16).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_union_add_card_inter' (s t : Finset ℕ) : (s ∪ t).card + (s ∩ t).card = s.card + t.card := by
  exact Finset.card_union_add_card_inter s t

end MathCorpus.Elementary.Combinatorics
