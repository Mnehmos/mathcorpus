import Mathlib
/-!
# Midpoint is equidistant from the endpoints

Packet: `elementary.geometry.midpoint_equidist.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The midpoint ((x1+x2)/2, (y1+y2)/2) is equidistant from the two endpoints of the segment.
Kernel-verified through the tracked proof-search loop (episode e46f7503).
-/

namespace MathCorpus.Elementary.Geometry

theorem midpoint_equidist (x1 y1 x2 y2 : ℝ) : ((x1 + x2) / 2 - x1) ^ 2 + ((y1 + y2) / 2 - y1) ^ 2 = ((x1 + x2) / 2 - x2) ^ 2 + ((y1 + y2) / 2 - y2) ^ 2 := by
  ring

end MathCorpus.Elementary.Geometry
