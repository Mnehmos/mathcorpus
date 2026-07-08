import Mathlib
/-!
# Reflection through the origin preserves squared distance

Packet: `elementary.geometry.reflection_dist.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Reflecting both coordinates through the origin preserves the squared one-dimensional distance.
Kernel-verified through the tracked proof-search loop (episode 73d0292f).
-/

namespace MathCorpus.Elementary.Geometry

theorem reflection_dist (x1 x2 : ℝ) : (-x2 - -x1) ^ 2 = (x2 - x1) ^ 2 := by
  ring

end MathCorpus.Elementary.Geometry
