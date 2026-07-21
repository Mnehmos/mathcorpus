import Mathlib

/-!
# Double inverse in a group

Packet: `undergrad.abstract_algebra.group_inv_inv.v1`
Level:  L3_undergrad · Domain: abstract_algebra · Trust rung 1 (Lean kernel).

The inverse of the inverse of an element in a group is the element itself.
-/

namespace MathCorpus.Undergrad.AbstractAlgebra

theorem group_inv_inv' {G : Type*} [Group G] (a : G) : (a⁻¹)⁻¹ = a := by
  exact inv_inv a

end MathCorpus.Undergrad.AbstractAlgebra
