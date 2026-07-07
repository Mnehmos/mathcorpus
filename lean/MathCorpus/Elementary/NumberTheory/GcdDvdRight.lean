import Mathlib
/-!
# gcd divides its second argument

Packet: `elementary.number_theory.gcd_dvd_right.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The gcd of a and b divides b.
Kernel-verified through the tracked proof-search loop (episode 38579e1f).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_dvd_right' (a b : ℕ) : Nat.gcd a b ∣ b := by
  exact Nat.gcd_dvd_right a b

end MathCorpus.Elementary.NumberTheory
