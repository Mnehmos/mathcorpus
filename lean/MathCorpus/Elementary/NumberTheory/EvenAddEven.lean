import Mathlib

/-!
# Sum of two even integers is even

Packet: `elementary.number_theory.even_add_even.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For integers a and b, if a is even and b is even then a + b is even.
Kernel-verified through the tracked proof-search loop (episode e7f39adc).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem even_add_even (a b : ℤ) (ha : Even a) (hb : Even b) : Even (a + b) := by
  exact ha.add hb

end MathCorpus.Elementary.NumberTheory
