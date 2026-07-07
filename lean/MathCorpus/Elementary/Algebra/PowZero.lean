import Mathlib
/-!
# Zeroth power is one

Packet: `elementary.algebra.pow_zero.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Any integer to the power zero equals one.
Kernel-verified through the tracked proof-search loop (episode 53ca466f).
-/

namespace MathCorpus.Elementary.Algebra

theorem pow_zero' (a : ℤ) : a ^ 0 = 1 := by
  exact pow_zero a

end MathCorpus.Elementary.Algebra
