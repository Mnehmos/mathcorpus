import Mathlib
/-!
# The image of a finite set is no larger than the set

Packet: `elementary.combinatorics.card_image_le.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The image of a finite set under a function has at most as many elements as the original set — applying a function can only merge elements, never create new ones.
Kernel-verified through the tracked proof-search loop (episode 56d41a21).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_image_le' (s : Finset ℕ) (f : ℕ → ℕ) : (s.image f).card ≤ s.card := by
  exact Finset.card_image_le

end MathCorpus.Elementary.Combinatorics
