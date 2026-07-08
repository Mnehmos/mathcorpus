import Mathlib
/-!
# Pigeonhole: 3 items into 2 boxes forces a repeated box

Packet: `elementary.combinatorics.pigeonhole_3_into_2.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

If 3 items are each placed into one of 2 boxes (modeled as a function from {0,1,2} into {0,1}), some two distinct items land in the same box — the pigeonhole principle's simplest concrete instance.
Kernel-verified through the tracked proof-search loop (episode f2716b47).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem pigeonhole_3_into_2 (f : ℕ → ℕ) (hf : ∀ a ∈ Finset.range 3, f a ∈ Finset.range 2) : ∃ x ∈ Finset.range 3, ∃ y ∈ Finset.range 3, x ≠ y ∧ f x = f y := by
  exact Finset.exists_ne_map_eq_of_card_lt_of_maps_to (by decide) hf

end MathCorpus.Elementary.Combinatorics
