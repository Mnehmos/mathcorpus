import Mathlib
/-!
# Sum of two odd integers is even

Packet: `elementary.number_theory.odd_add_odd.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For integers a and b, if a and b are both odd then a + b is even.
Kernel-verified through the tracked proof-search loop (episode a64980ce).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem odd_add_odd (a b : ℤ) (ha : Odd a) (hb : Odd b) : Even (a + b) := by
  exact ha.add_odd hb

end MathCorpus.Elementary.NumberTheory
