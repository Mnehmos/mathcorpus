import Mathlib
/-!
# Negation of the right factor

Packet: `elementary.algebra.mul_neg.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Negating the right factor negates the product.
Kernel-verified through the tracked proof-search loop (episode 6b5313b4).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_neg' (a b : ℤ) : a * -b = -(a * b) := by
  exact mul_neg a b

end MathCorpus.Elementary.Algebra
