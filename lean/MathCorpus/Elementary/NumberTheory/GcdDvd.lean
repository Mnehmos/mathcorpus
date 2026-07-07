import Mathlib
/-!
# gcd divides its first argument

Packet: `elementary.number_theory.gcd_dvd_left.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The gcd of a and b divides a.
Kernel-verified through the tracked proof-search loop (episode 6dcd9358).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_dvd_left' (a b : ℕ) : Nat.gcd a b ∣ a := by
  exact Nat.gcd_dvd_left a b

end MathCorpus.Elementary.NumberTheory
