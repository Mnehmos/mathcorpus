import Mathlib
/-!
# Zero is a left identity for addition

Packet: `elementary.algebra.zero_add.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Zero plus any integer is the integer.
Kernel-verified through the tracked proof-search loop (episode f1194bcc).
-/

namespace MathCorpus.Elementary.Algebra

theorem zero_add' (a : ℤ) : 0 + a = a := by
  exact zero_add a

end MathCorpus.Elementary.Algebra
