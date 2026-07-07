import Mathlib
/-!
# One is a left identity for multiplication

Packet: `elementary.algebra.one_mul.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

One times any integer is the integer.
Kernel-verified through the tracked proof-search loop (episode 96194d27).
-/

namespace MathCorpus.Elementary.Algebra

theorem one_mul' (a : ℤ) : 1 * a = a := by
  exact one_mul a

end MathCorpus.Elementary.Algebra
