import Mathlib
/-!
# Zero is a right identity for addition

Packet: `elementary.algebra.add_zero.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Any integer plus zero is the integer.
Kernel-verified through the tracked proof-search loop (episode 4c3121a9).
-/

namespace MathCorpus.Elementary.Algebra

theorem add_zero' (a : ℤ) : a + 0 = a := by
  exact add_zero a

end MathCorpus.Elementary.Algebra
