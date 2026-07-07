import Mathlib

/-!
# Sum of cubes

Packet: `elementary.algebra.sum_of_cubes.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For integers a and b, a^3 + b^3 = (a + b) * (a^2 - a*b + b^2).
Kernel-verified through the tracked proof-search loop (episode 208cda4f).
-/

namespace MathCorpus.Elementary.Algebra

theorem sum_cubes (a b : ℤ) : a ^ 3 + b ^ 3 = (a + b) * (a ^ 2 - a * b + b ^ 2) := by
  ring

end MathCorpus.Elementary.Algebra
