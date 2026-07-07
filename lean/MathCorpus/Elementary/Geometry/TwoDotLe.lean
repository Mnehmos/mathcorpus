import Mathlib
/-!
# Twice the dot product bound

Packet: `elementary.geometry.two_dot_le.v1`
Level:  L2_olympiad · Domain: geometry · Trust rung 1 (Lean kernel).

Twice the dot product of two plane vectors is at most the sum of their squared norms (2 u·v ≤ |u|² + |v|²).
Kernel-verified through the tracked proof-search loop (episode 23e38a80).
-/

namespace MathCorpus.Elementary.Geometry

theorem two_dot_le (x1 y1 x2 y2 : ℝ) : 2 * (x1 * x2 + y1 * y2) ≤ (x1 ^ 2 + y1 ^ 2) + (x2 ^ 2 + y2 ^ 2) := by
  nlinarith [sq_nonneg (x1 - x2), sq_nonneg (y1 - y2)]

end MathCorpus.Elementary.Geometry
