import Mathlib
/-!
# Cardinality of a set difference

Packet: `elementary.combinatorics.card_sdiff_of_subset.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

If t is a subset of s, the number of elements in s but not in t equals the size of s minus the size of t.
Kernel-verified through the tracked proof-search loop (episode 236baad7).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_sdiff_of_subset' (s t : Finset ℕ) (h : t ⊆ s) : (s \ t).card = s.card - t.card := by
  exact Finset.card_sdiff_of_subset h

end MathCorpus.Elementary.Combinatorics
