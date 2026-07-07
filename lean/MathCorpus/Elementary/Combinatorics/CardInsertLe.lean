import Mathlib
/-!
# Insertion increases cardinality by at most one

Packet: `elementary.combinatorics.card_insert_le.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

Inserting one element into a finite set increases its cardinality by at most one.
Kernel-verified through the tracked proof-search loop (episode cba8ec77).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_insert_le' (a : ℕ) (s : Finset ℕ) : (insert a s).card ≤ s.card + 1 := by
  exact Finset.card_insert_le a s

end MathCorpus.Elementary.Combinatorics
