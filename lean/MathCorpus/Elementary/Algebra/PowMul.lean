import Mathlib
/-!
# Exponent multiplication law

Packet: `elementary.algebra.pow_mul.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

x^(m*n) = (x^m)^n for a real base and natural exponents.
Kernel-verified through the tracked proof-search loop (episode 13c20f38).
-/

namespace MathCorpus.Elementary.Algebra

theorem pow_mul' (x : ℝ) (m n : ℕ) : x ^ (m * n) = (x ^ m) ^ n := by
  exact pow_mul x m n

end MathCorpus.Elementary.Algebra
