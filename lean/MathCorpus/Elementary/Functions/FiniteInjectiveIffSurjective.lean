import Mathlib
/-!
# Injective iff surjective for finite self-maps

Packet: `elementary.functions.finite_injective_iff_surjective.v1`
Level:  L1_proof_basics · Domain: functions · Trust rung 1 (Lean kernel).

For a finite type, a self-map is injective if and only if it is
surjective -- the classic pigeonhole-principle corollary, distinct from
the general (possibly infinite) case where injective and surjective are
independent properties.
Kernel-verified through the tracked proof-search loop (episode 1cace84e).
-/

namespace MathCorpus.Elementary.Functions

theorem finite_injective_iff_surjective (α : Type) [Finite α] (f : α → α) :
    Function.Injective f ↔ Function.Surjective f :=
  Finite.injective_iff_surjective

end MathCorpus.Elementary.Functions
