import Mathlib
/-!
# gcd with zero on the left

Packet: `elementary.number_theory.gcd_zero_left.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The gcd of 0 and n is n.
Kernel-verified through the tracked proof-search loop (episode bd95310c).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_zero_left' (n : ℕ) : Nat.gcd 0 n = n := by
  exact Nat.gcd_zero_left n

end MathCorpus.Elementary.NumberTheory
