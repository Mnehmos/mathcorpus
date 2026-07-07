import Mathlib
open scoped BigOperators

/-!
# Summing 1 over a finite set counts its elements

Packet: `elementary.combinatorics.sum_ones_card.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

Summing the constant 1 over a finite set equals the number of elements of the set.
Kernel-verified through the tracked proof-search loop (episode 81036d67).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem sum_ones_card (s : Finset ℕ) : (∑ _i ∈ s, (1 : ℕ)) = s.card := by
  simp

end MathCorpus.Elementary.Combinatorics
