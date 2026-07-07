import Mathlib
/-!
# Even times any integer is even

Packet: `elementary.number_theory.even_mul.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For integers a and b, if a is even then a * b is even.
Kernel-verified through the tracked proof-search loop (episode 826419fb).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem even_mul_right (a b : ℤ) (ha : Even a) : Even (a * b) := by
  exact ha.mul_right b

end MathCorpus.Elementary.NumberTheory
