import Mathlib
/-!
# Tripling the centroid coordinate

Packet: `elementary.geometry.centroid_sum.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Three times the centroid coordinate equals the sum of the vertex coordinates.
Kernel-verified through the tracked proof-search loop (episode 19db8e69).
-/

namespace MathCorpus.Elementary.Geometry

theorem centroid_sum (x1 x2 x3 : ℝ) : 3 * ((x1 + x2 + x3) / 3) = x1 + x2 + x3 := by
  ring

end MathCorpus.Elementary.Geometry
