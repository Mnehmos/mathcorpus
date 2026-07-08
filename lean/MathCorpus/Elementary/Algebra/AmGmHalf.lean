import Mathlib
/-!
# The product of two reals is at most the mean of their squares

Packet: `elementary.algebra.am_gm_half.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

The product of two reals is at most the mean of their squares.
Kernel-verified through the tracked proof-search loop (episode f7919dcb).
-/

namespace MathCorpus.Elementary.Algebra

theorem am_gm_half : ∀ (a b : ℝ), a * b ≤ (a ^ 2 + b ^ 2) / 2 := by
  intro a b; nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Algebra
