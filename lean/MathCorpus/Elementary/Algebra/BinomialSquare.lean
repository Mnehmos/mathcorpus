import Mathlib

/-!
# Binomial square

Packet: `elementary.algebra.binomial_square.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For integers `a` and `b`, `(a + b)^2` expands to `a^2 + 2*a*b + b^2`.
Kernel-verified through the tracked proof-search loop (episode 63611206).
-/

namespace MathCorpus.Elementary.Algebra

theorem binomial_sq (a b : ℤ) : (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by
  ring

end MathCorpus.Elementary.Algebra
