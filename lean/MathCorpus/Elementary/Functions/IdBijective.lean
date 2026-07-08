import Mathlib
/-!
# The identity function is bijective

Packet: `elementary.functions.id_bijective.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every type alpha, the identity function id : alpha -> alpha is bijective.
Kernel-verified through the tracked proof-search loop (episode 7bce298c).
-/

namespace MathCorpus.Elementary.Functions

theorem id_bijective : ∀ (α : Type), Function.Bijective (id : α → α) := by
  intro α
  exact ⟨fun a b hab => hab, fun b => ⟨b, rfl⟩⟩

end MathCorpus.Elementary.Functions
