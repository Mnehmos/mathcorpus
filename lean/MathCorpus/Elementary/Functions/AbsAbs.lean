import Mathlib
/-!
# Absolute value is idempotent

Packet: `elementary.functions.abs_abs.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Taking the absolute value twice equals taking it once.
Kernel-verified through the tracked proof-search loop (episode 2a4059c4).
-/

namespace MathCorpus.Elementary.Functions

theorem abs_abs' (a : ℝ) : |(|a|)| = |a| := by
  exact abs_abs a

end MathCorpus.Elementary.Functions
