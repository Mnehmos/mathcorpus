import Mathlib
/-!
# Image of an intersection is a subset of the intersection of images

Packet: `elementary.functions.image_inter_subset.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every function f : alpha -> beta and sets s, t : Set alpha:
f '' (s ∩ t) ⊆ f '' s ∩ f '' t. Only a subset in general -- equality needs f
injective, so this is deliberately the always-true subset version rather than a
false equality claim.
Kernel-verified through the tracked proof-search loop (episode 6eaaf620).
-/

namespace MathCorpus.Elementary.Functions

theorem image_inter_subset :
    ∀ {α β : Type} (f : α → β) (s t : Set α), f '' (s ∩ t) ⊆ f '' s ∩ f '' t := by
  intro α β f s t
  exact Set.image_inter_subset f s t

end MathCorpus.Elementary.Functions
