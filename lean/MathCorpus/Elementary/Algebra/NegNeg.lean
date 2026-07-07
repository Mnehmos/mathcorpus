import Mathlib
/-!
# Double negation

Packet: `elementary.algebra.neg_neg.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The negation of the negation of an integer is the integer.
Kernel-verified through the tracked proof-search loop (episode 01b63a9c).
-/

namespace MathCorpus.Elementary.Algebra

theorem neg_neg' (a : ℤ) : -(-a) = a := by
  exact neg_neg a

end MathCorpus.Elementary.Algebra
