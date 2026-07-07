import Mathlib
/-!
# A number minus itself is zero

Packet: `elementary.algebra.sub_self.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

An integer minus itself is zero.
Kernel-verified through the tracked proof-search loop (episode 15d4e169).
-/

namespace MathCorpus.Elementary.Algebra

theorem sub_self' (a : ℤ) : a - a = 0 := by
  exact sub_self a

end MathCorpus.Elementary.Algebra
