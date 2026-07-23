import Mathlib

/-!
# Composition of an injective function with itself is injective

Packet: `logic.functions.injective_comp_self.v1`
Level:  L1_proof_basics · Domain: logic · Trust rung 1 (Lean kernel).

If a function is injective, its self-composition is also injective.
-/

namespace MathCorpus.Elementary.Logic

theorem injective_comp_self' : ∀ {α : Type*} (f : α → α), Function.Injective f → Function.Injective (f ∘ f) := by
  intro α f hf
  exact hf.comp hf

end MathCorpus.Elementary.Logic
