import Mathlib
/-!
# Right distributivity

Packet: `elementary.algebra.add_mul.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Multiplication distributes over addition on the right.
Kernel-verified through the tracked proof-search loop (episode 0d2009b2).
-/

namespace MathCorpus.Elementary.Algebra

theorem add_mul' (a b c : ℤ) : (a + b) * c = a * c + b * c := by
  exact add_mul a b c

end MathCorpus.Elementary.Algebra
