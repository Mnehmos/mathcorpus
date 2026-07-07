import Mathlib

/-!
# Square of a difference

Packet: `elementary.algebra.square_of_difference.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For integers `a` and `b`, `(a - b)^2 = a^2 - 2*a*b + b^2`.
Kernel-verified through the tracked proof-search loop (episode 60dbf56e).
-/

namespace MathCorpus.Elementary.Algebra

theorem sub_sq (a b : ℤ) : (a - b) ^ 2 = a ^ 2 - 2 * a * b + b ^ 2 := by
  ring

end MathCorpus.Elementary.Algebra
