import Mathlib
/-!
# Multiplication is commutative

Packet: `elementary.algebra.mul_comm.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Integer multiplication is commutative.
Kernel-verified through the tracked proof-search loop (episode 6ab493cd).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_comm' (a b : ℤ) : a * b = b * a := by
  exact mul_comm a b

end MathCorpus.Elementary.Algebra
