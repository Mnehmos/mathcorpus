import Mathlib
/-!
# Subtracting zero

Packet: `elementary.algebra.sub_zero.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Subtracting zero leaves a number unchanged.
Kernel-verified through the tracked proof-search loop (episode 077602af).
-/

namespace MathCorpus.Elementary.Algebra

theorem sub_zero' (a : ℤ) : a - 0 = a := by
  exact sub_zero a

end MathCorpus.Elementary.Algebra
