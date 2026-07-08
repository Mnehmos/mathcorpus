import Mathlib

/-!
# Adding fractions with the same denominator

Packet: `elementary.algebra.div_add_div_same.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

a/c + b/c = (a+b)/c for reals. The domain's first division-identity
packet.
Kernel-verified through the tracked proof-search loop (episode cd6b4dc2).
-/

namespace MathCorpus.Elementary.Algebra

theorem div_add_div_same' (a b c : ℝ) : a / c + b / c = (a + b) / c := by ring

end MathCorpus.Elementary.Algebra
