import Mathlib

/-!
# Difference of cubes

Packet: `elementary.algebra.diff_of_cubes.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For integers `a` and `b`, `a^3 - b^3 = (a - b) * (a^2 + a*b + b^2)`.
Kernel-verified through the tracked proof-search loop (episode 970fe8c1).
-/

namespace MathCorpus.Elementary.Algebra

theorem diff_cubes (a b : ℤ) : a ^ 3 - b ^ 3 = (a - b) * (a ^ 2 + a * b + b ^ 2) := by
  ring

end MathCorpus.Elementary.Algebra
