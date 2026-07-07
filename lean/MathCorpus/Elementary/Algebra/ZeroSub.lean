import Mathlib
/-!
# Zero minus a

Packet: `elementary.algebra.zero_sub.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Zero minus a equals the negation of a.
Kernel-verified through the tracked proof-search loop (episode 7fd53224).
-/

namespace MathCorpus.Elementary.Algebra

theorem zero_sub' (a : ℤ) : 0 - a = -a := by
  exact zero_sub a

end MathCorpus.Elementary.Algebra
