import Mathlib
/-!
# Image of a union is the union of images

Packet: `elementary.functions.image_union.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every function f : alpha -> beta and sets s, t : Set alpha:
f '' (s ∪ t) = f '' s ∪ f '' t.
Kernel-verified through the tracked proof-search loop (episode 5ca732f2).
-/

namespace MathCorpus.Elementary.Functions

theorem image_union : ∀ {α β : Type} (f : α → β) (s t : Set α), f '' (s ∪ t) = f '' s ∪ f '' t := by
  intro α β f s t
  exact Set.image_union f s t

end MathCorpus.Elementary.Functions
