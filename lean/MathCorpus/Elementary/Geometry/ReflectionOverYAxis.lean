import Mathlib
/-!
# Reflection over the y-axis preserves distance to points on the y-axis

Packet: `elementary.geometry.reflection_over_y_axis.v1`
Level:  L0_elementary · Domain: geometry · Trust rung 1 (Lean kernel).

Reflecting a point (x, y) over the y-axis to (-x, y) preserves its
squared distance to any point (0, qy) lying on the y-axis, since the
x-coordinate contributes x^2 = (-x)^2 either way. The y-axis companion
to the domain's existing `reflection_over_x_axis`.
Kernel-verified through the tracked proof-search loop (episode ecc942d6).
-/

namespace MathCorpus.Elementary.Geometry

theorem reflection_over_y_axis (x y qy : ℝ) :
    x ^ 2 + (y - qy) ^ 2 = (-x) ^ 2 + (y - qy) ^ 2 := by
  ring

end MathCorpus.Elementary.Geometry
