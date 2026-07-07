import Mathlib
/-!
# Squared distance is nonnegative

Packet: `elementary.geometry.distance_sq_nonneg.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The squared Euclidean distance between two plane points is nonnegative.
Kernel-verified through the tracked proof-search loop (episode b85bdcf8).
-/

namespace MathCorpus.Elementary.Geometry

theorem distance_sq_nonneg (x1 y1 x2 y2 : ℝ) : 0 ≤ (x2 - x1) ^ 2 + (y2 - y1) ^ 2 := by
  positivity

end MathCorpus.Elementary.Geometry
