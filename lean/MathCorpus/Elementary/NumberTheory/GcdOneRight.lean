import Mathlib
/-!
# gcd with one on the right

Packet: `elementary.number_theory.gcd_one_right.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The gcd of any natural number with 1 is 1.
Kernel-verified through the tracked proof-search loop (episode 2fd97291).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_one_right' (n : ℕ) : Nat.gcd n 1 = 1 := by
  exact Nat.gcd_one_right n

end MathCorpus.Elementary.NumberTheory
