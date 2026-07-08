import Mathlib

/-!
# Squaring a negation

Packet: `elementary.algebra.neg_sq.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

(-a) ^ 2 = a ^ 2. Natural companion to `mul_neg'`/`neg_neg'`/`pow_two`.
Kernel-verified through the tracked proof-search loop (episode 2ccf64f3).
-/

namespace MathCorpus.Elementary.Algebra

theorem neg_sq' (a : ℤ) : (-a) ^ 2 = a ^ 2 := by ring

end MathCorpus.Elementary.Algebra
