import Mathlib

/-!
# Factoring by grouping

Packet: `elementary.algebra.factor_by_grouping.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For integers a, b, c, d, a*c + a*d + b*c + b*d = (a + b) * (c + d).
Kernel-verified through the tracked proof-search loop (episode 1f5692bb).
-/

namespace MathCorpus.Elementary.Algebra

theorem factor_by_grouping (a b c d : ℤ) : a * c + a * d + b * c + b * d = (a + b) * (c + d) := by
  ring

end MathCorpus.Elementary.Algebra
