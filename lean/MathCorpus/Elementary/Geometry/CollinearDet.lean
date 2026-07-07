import Mathlib
/-!
# Equal-slope collinearity vanishes the area determinant

Packet: `elementary.geometry.collinear_det.v1`
Level:  L2_olympiad · Domain: geometry · Trust rung 1 (Lean kernel).

If three points have equal slopes from the first (collinear), the signed-area determinant is zero.
Kernel-verified through the tracked proof-search loop (episode 914027e2).
-/

namespace MathCorpus.Elementary.Geometry

theorem collinear_det (x1 y1 x2 y2 x3 y3 : ℝ) (h : (y2 - y1) * (x3 - x1) = (y3 - y1) * (x2 - x1)) : (x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1) = 0 := by
  linear_combination -h

end MathCorpus.Elementary.Geometry
