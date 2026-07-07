import Mathlib
/-!
# Supplementary angles

Packet: `elementary.geometry.supplementary_angle.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

If two angles are supplementary (sum to π) then each equals π minus the other.
Kernel-verified through the tracked proof-search loop (episode 162c7375).
-/

namespace MathCorpus.Elementary.Geometry

theorem supplementary_angle (a b : ℝ) (h : a + b = Real.pi) : a = Real.pi - b := by
  linarith

end MathCorpus.Elementary.Geometry
