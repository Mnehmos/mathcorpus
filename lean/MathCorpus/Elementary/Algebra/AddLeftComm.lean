import Mathlib
/-!
# Left commutativity of addition

Packet: `elementary.algebra.add_left_comm.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The left summand can be swapped past a nested sum.
Kernel-verified through the tracked proof-search loop (episode d369e13a).
-/

namespace MathCorpus.Elementary.Algebra

theorem add_left_comm' (a b c : ℤ) : a + (b + c) = b + (a + c) := by
  exact add_left_comm a b c

end MathCorpus.Elementary.Algebra
