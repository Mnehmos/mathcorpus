import Mathlib

/-!
# Intersection of a set with itself is itself

Packet: `logic.set.inter_self.v1`
Level:  L0_elementary · Domain: logic · Trust rung 1 (Lean kernel).

The intersection of a set with itself equals the set.
-/

namespace MathCorpus.Elementary.Logic

theorem set_inter_self' : ∀ {α : Type*} (s : Set α), s ∩ s = s := by
  intro α s
  exact Set.inter_self s

end MathCorpus.Elementary.Logic
