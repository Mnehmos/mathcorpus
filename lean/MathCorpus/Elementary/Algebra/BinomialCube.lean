import Mathlib

/-!
# Binomial cube

Packet: `elementary.algebra.binomial_cube.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For integers a and b, (a + b)^3 = a^3 + 3*a^2*b + 3*a*b^2 + b^3.
Kernel-verified through the tracked proof-search loop (episode fae80a61).
-/

namespace MathCorpus.Elementary.Algebra

theorem binomial_cube (a b : ℤ) : (a + b) ^ 3 = a ^ 3 + 3 * a ^ 2 * b + 3 * a * b ^ 2 + b ^ 3 := by
  ring

end MathCorpus.Elementary.Algebra
