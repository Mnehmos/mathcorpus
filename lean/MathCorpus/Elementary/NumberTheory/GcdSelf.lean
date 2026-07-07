import Mathlib
/-!
# gcd of a number with itself

Packet: `elementary.number_theory.gcd_self.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The gcd of a number with itself is the number.
Kernel-verified through the tracked proof-search loop (episode cd45a8b2).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_self' (n : ℕ) : Nat.gcd n n = n := by
  exact Nat.gcd_self n

end MathCorpus.Elementary.NumberTheory
