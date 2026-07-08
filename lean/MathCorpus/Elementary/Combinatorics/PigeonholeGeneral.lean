import Mathlib
/-!
# The pigeonhole principle, general form

Packet: `elementary.combinatorics.pigeonhole_general.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

General pigeonhole principle: if s and t are finite sets of naturals with t strictly smaller than s, and f maps every element of s into t, then some two distinct elements of s collide under f.
Kernel-verified through the tracked proof-search loop (episode d9b60f62).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem pigeonhole_general (s t : Finset ℕ) (f : ℕ → ℕ) (hc : t.card < s.card) (hf : ∀ a ∈ s, f a ∈ t) : ∃ x ∈ s, ∃ y ∈ s, x ≠ y ∧ f x = f y := by
  exact Finset.exists_ne_map_eq_of_card_lt_of_maps_to hc hf

end MathCorpus.Elementary.Combinatorics
