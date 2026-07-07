import Mathlib
/-!
# Negation of the left factor

Packet: `elementary.algebra.neg_mul.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Negating the left factor negates the product.
Kernel-verified through the tracked proof-search loop (episode b89996e3).
-/

namespace MathCorpus.Elementary.Algebra

theorem neg_mul' (a b : ℤ) : -a * b = -(a * b) := by
  exact neg_mul a b

end MathCorpus.Elementary.Algebra
