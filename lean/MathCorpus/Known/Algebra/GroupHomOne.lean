import Mathlib

/-!
# Group homomorphism preserves identity element

Packet: `algebra.group_hom_one.v1`
Level:  L6_known_theorem · Domain: algebra · Trust rung 1 (Lean kernel).

For any group homomorphism f : G →* H, f 1 = 1.
-/

namespace MathCorpus.Known.Algebra

theorem group_hom_one' : ∀ {G H : Type*} [Group G] [Group H] (f : G →* H), f 1 = 1 := by
  intro G H instG instH f
  exact map_one f

end MathCorpus.Known.Algebra
