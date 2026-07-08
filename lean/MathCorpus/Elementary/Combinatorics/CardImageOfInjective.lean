import Mathlib
/-!
# An injective function preserves cardinality on a finite set

Packet: `elementary.combinatorics.card_image_of_injective.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

If f is injective, the image of a finite set s under f has exactly the same cardinality as s (no elements merge).
Kernel-verified through the tracked proof-search loop (episode 5f59b5d8).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_image_of_injective' (s : Finset ℕ) (f : ℕ → ℕ) (hf : Function.Injective f) : (s.image f).card = s.card := by
  exact Finset.card_image_of_injective s hf

end MathCorpus.Elementary.Combinatorics
