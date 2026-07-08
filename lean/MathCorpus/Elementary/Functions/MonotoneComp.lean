import Mathlib

/-!
# Composition of monotone functions is monotone

Packet: `elementary.functions.monotone_comp.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For preordered α, β, γ, if f : α → β and g : β → γ are both monotone, then
their composition g ∘ f : α → γ is monotone. Completes the composition
trio alongside `injective_comp` and `surjective_comp`.
Kernel-verified through the tracked proof-search loop (episode c8b140d2).
-/

namespace MathCorpus.Elementary.Functions

theorem monotone_comp {α β γ : Type*} [Preorder α] [Preorder β] [Preorder γ]
    (f : α → β) (g : β → γ) (hf : Monotone f) (hg : Monotone g) :
    Monotone (g ∘ f) := by
  intro a b hab
  exact hg (hf hab)

end MathCorpus.Elementary.Functions
