import Mathlib
/-!
# Divisibility is preserved under multiplication

Packet: `elementary.number_theory.dvd_mul.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For integers a, b, c, if a divides b then a divides b * c.
Kernel-verified through the tracked proof-search loop (episode 988f5d32).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_mul_right' (a b c : ℤ) (hb : a ∣ b) : a ∣ b * c := by
  exact hb.mul_right c

end MathCorpus.Elementary.NumberTheory
