import Mathlib
/-!
# Composition of surjective functions is surjective

Packet: `elementary.functions.surjective_comp.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

If f : alpha -> beta and g : beta -> gamma are both surjective, then g ∘ f is surjective.
Kernel-verified through the tracked proof-search loop (episode fd3f917e).
-/

namespace MathCorpus.Elementary.Functions

theorem surjective_comp :
    ∀ {α β γ : Type} (f : α → β) (g : β → γ),
      Function.Surjective f → Function.Surjective g → Function.Surjective (g ∘ f) := by
  intro α β γ f g hf hg c
  obtain ⟨b, hb⟩ := hg c
  obtain ⟨a, ha⟩ := hf b
  exact ⟨a, by rw [Function.comp_apply, ha, hb]⟩

end MathCorpus.Elementary.Functions
