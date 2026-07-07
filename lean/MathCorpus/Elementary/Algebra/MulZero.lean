import Mathlib
/-!
# Anything times zero is zero

Packet: `elementary.algebra.mul_zero.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Any integer times zero is zero.
Kernel-verified through the tracked proof-search loop (episode 577b301c).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_zero' (a : ℤ) : a * 0 = 0 := by
  exact mul_zero a

end MathCorpus.Elementary.Algebra
