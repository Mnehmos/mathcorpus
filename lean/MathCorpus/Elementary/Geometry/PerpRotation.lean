import Mathlib
/-!
# A vector is perpendicular to its 90-degree rotation

Packet: `elementary.geometry.perp_rotation.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The dot product of (a,b) with its 90-degree rotation (b,-a) is zero, i.e. they are perpendicular.
Kernel-verified through the tracked proof-search loop (episode ba6d1c03).
-/

namespace MathCorpus.Elementary.Geometry

theorem perp_rotation (a b : ℝ) : a * b + b * (-a) = 0 := by
  ring

end MathCorpus.Elementary.Geometry
