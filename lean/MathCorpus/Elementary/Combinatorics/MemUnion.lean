import Mathlib
/-!
# Membership in a union

Packet: `elementary.combinatorics.mem_union.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

An element is in a union exactly when it is in one of the two sets.
Kernel-verified through the tracked proof-search loop (episode bd77a4da).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem mem_union' (a : ℕ) (s t : Finset ℕ) : a ∈ s ∪ t ↔ a ∈ s ∨ a ∈ t := by
  exact Finset.mem_union

end MathCorpus.Elementary.Combinatorics
