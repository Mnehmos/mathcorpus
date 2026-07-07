import Mathlib
/-!
# First power is the base

Packet: `elementary.algebra.pow_one.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Any integer to the first power equals itself.
Kernel-verified through the tracked proof-search loop (episode 18029852).
-/

namespace MathCorpus.Elementary.Algebra

theorem pow_one' (a : ℤ) : a ^ 1 = a := by
  exact pow_one a

end MathCorpus.Elementary.Algebra
