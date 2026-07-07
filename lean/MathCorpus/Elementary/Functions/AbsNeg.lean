import Mathlib
/-!
# Absolute value of a negation

Packet: `elementary.functions.abs_neg.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The absolute value of -a equals the absolute value of a.
Kernel-verified through the tracked proof-search loop (episode 326778ec).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_neg' (a : ℝ) : |(-a)| = |a| := by
  exact abs_neg a

end MathCorpus.Elementary.Functions
