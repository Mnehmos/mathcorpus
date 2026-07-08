import Mathlib
/-!
# Pythagorean theorem (squared-distance form)

Packet: `elementary.geometry.pythagorean_right_angle.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

For coordinate points A=(x1,y1), B=(x2,y2), C=(x3,y3) with a right angle at B
(the vectors A-B and C-B are perpendicular, i.e. their dot product is zero),
the squared distance from A to C equals the sum of the squared distances
from A to B and from B to C.
Kernel-verified through the tracked proof-search loop (episode 1ee45ae1).
-/

namespace MathCorpus.Elementary.Geometry

theorem pythagorean_right_angle (x1 y1 x2 y2 x3 y3 : ℝ)
    (h : (x1 - x2) * (x3 - x2) + (y1 - y2) * (y3 - y2) = 0) :
    (x1 - x3) ^ 2 + (y1 - y3) ^ 2 =
      ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) + ((x2 - x3) ^ 2 + (y2 - y3) ^ 2) := by
  nlinarith [h]

end MathCorpus.Elementary.Geometry
