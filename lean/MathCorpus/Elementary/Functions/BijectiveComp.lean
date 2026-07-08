import Mathlib
/-!
# Composition of bijective functions is bijective

Packet: `elementary.functions.bijective_comp.v1`
Level:  L1_proof_basics · Domain: functions · Trust rung 1 (Lean kernel).

The composition of two bijective functions is bijective -- completes
the domain's `injective_comp`/`surjective_comp` pair with the combined
`Bijective` statement.
Kernel-verified through the tracked proof-search loop (episode 0b5fbe31).
-/

namespace MathCorpus.Elementary.Functions

theorem bijective_comp (α β γ : Type) (f : α → β) (g : β → γ)
    (hf : Function.Bijective f) (hg : Function.Bijective g) :
    Function.Bijective (g ∘ f) :=
  ⟨hg.injective.comp hf.injective, hg.surjective.comp hf.surjective⟩

end MathCorpus.Elementary.Functions
