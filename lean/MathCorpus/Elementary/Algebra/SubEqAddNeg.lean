import Mathlib
/-!
# Subtraction as addition of negation

Packet: `elementary.algebra.sub_eq_add_neg.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Subtraction equals adding the negation.
Kernel-verified through the tracked proof-search loop (episode 48c21fb0).
-/

namespace MathCorpus.Elementary.Algebra

theorem sub_eq_add_neg' (a b : ℤ) : a - b = a + -b := by
  exact sub_eq_add_neg a b

end MathCorpus.Elementary.Algebra
