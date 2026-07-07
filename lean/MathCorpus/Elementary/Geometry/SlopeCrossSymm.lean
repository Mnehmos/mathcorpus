import Mathlib
/-!
# Slope cross-product symmetry

Packet: `elementary.geometry.slope_cross_symm.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The slope cross-product is invariant under swapping the two points.
Kernel-verified through the tracked proof-search loop (episode ffd08fc5).
-/

namespace MathCorpus.Elementary.Geometry

theorem slope_cross_symm (x1 y1 x2 y2 : ℝ) : (y2 - y1) * (x1 - x2) = (y1 - y2) * (x2 - x1) := by
  ring

end MathCorpus.Elementary.Geometry
