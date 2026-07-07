import Mathlib
/-!
# Cardinality is monotone under subset

Packet: `elementary.combinatorics.card_le_of_subset.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

A subset of a finite set has at most as many elements as the set.
Kernel-verified through the tracked proof-search loop (episode 9b045432).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_le_card' (s t : Finset ℕ) (h : s ⊆ t) : s.card ≤ t.card := by
  exact Finset.card_le_card h

end MathCorpus.Elementary.Combinatorics
