import Mathlib
/-!
# Membership in an intersection

Packet: `elementary.combinatorics.mem_inter.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

An element is in an intersection exactly when it is in both sets.
Kernel-verified through the tracked proof-search loop (episode d0eaebf2).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem mem_inter' (a : ℕ) (s t : Finset ℕ) : a ∈ s ∩ t ↔ a ∈ s ∧ a ∈ t := by
  exact Finset.mem_inter

end MathCorpus.Elementary.Combinatorics
