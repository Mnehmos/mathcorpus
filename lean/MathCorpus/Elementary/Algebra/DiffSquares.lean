import Mathlib

/-!
# Difference of squares

Packet: `elementary.algebra.diff_of_squares.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For integers `a` and `b`, `a^2 - b^2` factors as `(a - b) * (a + b)`.
-/

namespace MathCorpus.Elementary.Algebra

theorem diff_sq (a b : ℤ) : a ^ 2 - b ^ 2 = (a - b) * (a + b) := by
  ring

end MathCorpus.Elementary.Algebra
