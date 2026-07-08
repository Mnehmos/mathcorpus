import Mathlib
/-!
# Cardinality of an indexed union is subadditive

Packet: `elementary.combinatorics.card_bi_union_le.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The cardinality of an indexed union of finite sets (over an index set s, each index i contributing the set t i) is at most the sum of the individual cardinalities — the finite-union generalization of card_union_le.
Kernel-verified through the tracked proof-search loop (episode e3c5ed4b).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_biUnion_le' (s : Finset ℕ) (t : ℕ → Finset ℕ) : (s.biUnion t).card ≤ ∑ i ∈ s, (t i).card := by
  exact Finset.card_biUnion_le

end MathCorpus.Elementary.Combinatorics
