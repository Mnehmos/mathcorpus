import Mathlib
/-!
# Squared distance is symmetric

Packet: `elementary.geometry.dist_sq_symm.v1`
Level:  L0_elementary · Domain: geometry · Trust rung 1 (Lean kernel).

The squared Euclidean distance between two points in the plane is symmetric in the two points.
Kernel-verified through the tracked proof-search loop (episode afa21215).
-/

namespace MathCorpus.Elementary.Geometry

theorem dist_sq_symm (x1 y1 x2 y2 : ℝ) : (x2 - x1) ^ 2 + (y2 - y1) ^ 2 = (x1 - x2) ^ 2 + (y1 - y2) ^ 2 := by
  ring

end MathCorpus.Elementary.Geometry
