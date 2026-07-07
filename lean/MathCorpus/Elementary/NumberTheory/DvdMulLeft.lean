import Mathlib
/-!
# a divides b times a

Packet: `elementary.number_theory.dvd_mul_left.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For naturals a and b, a divides b * a.
Kernel-verified through the tracked proof-search loop (episode 97ca49f9).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_mul_left' (a b : ℕ) : a ∣ b * a := by
  exact dvd_mul_left a b

end MathCorpus.Elementary.NumberTheory
