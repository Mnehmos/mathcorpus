import Mathlib
/-!
# One is a right identity for multiplication

Packet: `elementary.algebra.mul_one.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Any integer times one is the integer.
Kernel-verified through the tracked proof-search loop (episode 84013391).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_one' (a : ℤ) : a * 1 = a := by
  exact mul_one a

end MathCorpus.Elementary.Algebra
