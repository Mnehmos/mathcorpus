import Mathlib
/-!
# Reflection over the x-axis preserves distance to points on the axis

Packet: `elementary.geometry.reflection_over_x_axis.v1`
Level:  L0_elementary · Domain: geometry · Trust rung 1 (Lean kernel).

Reflecting a point (x, y) over the x-axis to (x, -y) preserves its squared
distance to any point (qx, 0) that lies on the x-axis.
Kernel-verified through the tracked proof-search loop (episode 66dcb53d).
-/

namespace MathCorpus.Elementary.Geometry

theorem reflection_over_x_axis (x y qx : ℝ) :
    (x - qx) ^ 2 + y ^ 2 = (x - qx) ^ 2 + (-y) ^ 2 := by
  ring

end MathCorpus.Elementary.Geometry
