import Mathlib
/-!
# Exponent addition law

Packet: `elementary.algebra.pow_add.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

x^(m+n) = x^m * x^n for a real base and natural exponents.
Kernel-verified through the tracked proof-search loop (episode fa0521fa).
-/

namespace MathCorpus.Elementary.Algebra

theorem pow_add' (x : ℝ) (m n : ℕ) : x ^ (m + n) = x ^ m * x ^ n := by
  ring

end MathCorpus.Elementary.Algebra
