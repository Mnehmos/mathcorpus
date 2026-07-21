import Mathlib

/-!
# Scalar multiplication with zero vector

Packet: `undergrad.linear_algebra.smul_zero_vector.v1`
Level:  L3_undergrad · Domain: linear_algebra · Trust rung 1 (Lean kernel).

Scalar multiplication of any scalar with the zero vector in a module yields the zero vector.
-/

namespace MathCorpus.Undergrad.LinearAlgebra

theorem smul_zero_vector' {R V : Type*} [Semiring R] [AddCommMonoid V] [Module R V] (c : R) :
    c • (0 : V) = 0 := by
  exact smul_zero c

end MathCorpus.Undergrad.LinearAlgebra
