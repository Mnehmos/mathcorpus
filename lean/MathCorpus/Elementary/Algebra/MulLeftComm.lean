import Mathlib
/-!
# Left commutativity of multiplication

Packet: `elementary.algebra.mul_left_comm.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The left factor of a product can be swapped past a nested product.
Kernel-verified through the tracked proof-search loop (episode 54955b4a).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_left_comm' (a b c : ℤ) : a * (b * c) = b * (a * c) := by
  exact mul_left_comm a b c

end MathCorpus.Elementary.Algebra
