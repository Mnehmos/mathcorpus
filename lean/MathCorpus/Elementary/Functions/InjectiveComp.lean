import Mathlib
/-!
# Composition of injective functions is injective

Packet: `elementary.functions.injective_comp.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

If f : alpha -> beta and g : beta -> gamma are both injective, then g ∘ f is injective.
Kernel-verified through the tracked proof-search loop (episode ab41c15c).
-/

namespace MathCorpus.Elementary.Functions

theorem injective_comp :
    ∀ {α β γ : Type} (f : α → β) (g : β → γ),
      Function.Injective f → Function.Injective g → Function.Injective (g ∘ f) := by
  intro α β γ f g hf hg a b hab
  apply hf
  apply hg
  exact hab

end MathCorpus.Elementary.Functions
