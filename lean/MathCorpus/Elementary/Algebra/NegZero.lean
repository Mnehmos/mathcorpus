import Mathlib
/-!
# Negation of zero

Packet: `elementary.algebra.neg_zero.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The negation of zero is zero.
Kernel-verified through the tracked proof-search loop (episode 7f72991d).
-/

namespace MathCorpus.Elementary.Algebra

theorem neg_zero' : (-0 : ℤ) = 0 := by
  exact neg_zero

end MathCorpus.Elementary.Algebra
