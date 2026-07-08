import Mathlib

/-!
# Preimage of an intersection is the intersection of preimages

Packet: `elementary.functions.preimage_inter.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every function f : α → β and sets s, t : Set β: the preimage of the
intersection f ⁻¹' (s ∩ t) equals the intersection of the preimages
f ⁻¹' s ∩ f ⁻¹' t. Preimage counterpart to `image_union`.
Kernel-verified through the tracked proof-search loop (episode c14540a7).
-/

namespace MathCorpus.Elementary.Functions

theorem preimage_inter {α β : Type*} (f : α → β) (s t : Set β) :
    f ⁻¹' (s ∩ t) = f ⁻¹' s ∩ f ⁻¹' t :=
  Set.preimage_inter

end MathCorpus.Elementary.Functions
