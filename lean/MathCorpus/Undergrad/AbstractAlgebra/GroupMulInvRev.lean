import Mathlib

/-!
# Inverse of a product in a group

Packet: `undergrad.abstract_algebra.group_mul_inv_rev.v1`
Level:  L3_undergrad · Domain: abstract_algebra · Trust rung 1 (Lean kernel).

The inverse of a product of two group elements is the product of their inverses in reverse order.
-/

namespace MathCorpus.Undergrad.AbstractAlgebra

theorem group_mul_inv_rev' {G : Type*} [Group G] (a b : G) : (a * b)⁻¹ = b⁻¹ * a⁻¹ := by
  exact mul_inv_rev a b

end MathCorpus.Undergrad.AbstractAlgebra
