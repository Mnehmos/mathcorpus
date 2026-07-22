import Mathlib

/-!
# The kernel of a group homomorphism is a normal subgroup

Packet: `known.algebra.group_hom_kernel_normal.v1`
Level:  L6_known_theorem · Domain: algebra · Trust rung 1 (Lean kernel).

For any group homomorphism f : G →* H, its kernel (MonoidHom.ker f) is a normal subgroup of G.
-/

namespace MathCorpus.Known.Algebra

theorem monoid_hom_ker_normal' : ∀ {G H : Type*} [Group G] [Group H] (f : G →* H), (MonoidHom.ker f).Normal := by
  intro G H instG instH f
  infer_instance

end MathCorpus.Known.Algebra
