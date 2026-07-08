import Mathlib
/-!
# The form a^2 - ab + b^2 is nonnegative

Packet: `elementary.algebra.quad_form_nonneg.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

The form a^2 - ab + b^2 is nonnegative.
Kernel-verified through the tracked proof-search loop (episode 62339a0b).
-/

namespace MathCorpus.Elementary.Algebra

theorem quad_form_nonneg : ∀ (a b : ℝ), 0 ≤ a ^ 2 - a * b + b ^ 2 := by
  intro a b; nlinarith [sq_nonneg (2 * a - b), sq_nonneg b]

end MathCorpus.Elementary.Algebra
