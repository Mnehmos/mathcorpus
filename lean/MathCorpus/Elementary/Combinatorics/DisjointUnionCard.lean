import Mathlib
/-!
# Cardinality of a disjoint union is additive

Packet: `elementary.combinatorics.disjoint_union_card.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

If two finite sets are disjoint, the number of elements in their union equals the sum of their individual sizes.
Kernel-verified through the tracked proof-search loop (episode c0c34f8f).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem disjoint_union_card' (s t : Finset ℕ) (h : Disjoint s t) : (s ∪ t).card = s.card + t.card := by
  exact (Finset.card_union_eq_card_add_card).mpr h

end MathCorpus.Elementary.Combinatorics
