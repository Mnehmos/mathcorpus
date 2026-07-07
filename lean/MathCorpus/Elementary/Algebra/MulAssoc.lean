import Mathlib
/-!
# Multiplication is associative

Packet: `elementary.algebra.mul_assoc.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Integer multiplication is associative.
Kernel-verified through the tracked proof-search loop (episode a170e77c).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_assoc' (a b c : ℤ) : a * b * c = a * (b * c) := by
  exact mul_assoc a b c

end MathCorpus.Elementary.Algebra
