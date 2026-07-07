import Mathlib
/-!
# Addition is associative

Packet: `elementary.algebra.add_assoc.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Integer addition is associative.
Kernel-verified through the tracked proof-search loop (episode d3dd664a).
-/

namespace MathCorpus.Elementary.Algebra

theorem add_assoc' (a b c : ℤ) : a + b + c = a + (b + c) := by
  exact add_assoc a b c

end MathCorpus.Elementary.Algebra
