import Mathlib
/-!
# The square is the product of a number with itself

Packet: `elementary.algebra.pow_two.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The square is the product of a number with itself.
Kernel-verified through the tracked proof-search loop (episode f9f3622f).
-/

namespace MathCorpus.Elementary.Algebra

theorem pow_two : ∀ (a : ℤ), a ^ 2 = a * a := by
  intro a; exact _root_.pow_two a

end MathCorpus.Elementary.Algebra
