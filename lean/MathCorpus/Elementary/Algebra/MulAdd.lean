import Mathlib
/-!
# Left distributivity

Packet: `elementary.algebra.mul_add.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Multiplication distributes over addition on the left.
Kernel-verified through the tracked proof-search loop (episode ed5cfdfa).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_add' (a b c : ℤ) : a * (b + c) = a * b + a * c := by
  exact mul_add a b c

end MathCorpus.Elementary.Algebra
