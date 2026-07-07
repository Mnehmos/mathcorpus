import Mathlib
/-!
# Two times a is a plus a

Packet: `elementary.algebra.two_mul.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every integer a, 2a = a + a.
Kernel-verified through the tracked proof-search loop (episode df459fc2).
-/

namespace MathCorpus.Elementary.Algebra

theorem two_mul' (a : ℤ) : 2 * a = a + a := by
  exact two_mul a

end MathCorpus.Elementary.Algebra
