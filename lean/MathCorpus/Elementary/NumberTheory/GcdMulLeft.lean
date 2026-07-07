import Mathlib
/-!
# gcd distributes over a common factor

Packet: `elementary.number_theory.gcd_mul_left.v1`
Level:  L2_olympiad · Domain: number_theory · Trust rung 1 (Lean kernel).

gcd(k*m, k*n) = k * gcd(m, n): the gcd pulls out a common factor.
Kernel-verified through the tracked proof-search loop (episode c4f2e20e).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_mul_left' (k m n : ℕ) : Nat.gcd (k * m) (k * n) = k * Nat.gcd m n := by
  exact Nat.gcd_mul_left k m n

end MathCorpus.Elementary.NumberTheory
