import Mathlib
/-!
# Exterior-angle relation

Packet: `elementary.geometry.exterior_angle.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

If a triangle's angles sum to π, two of them sum to π minus the third (the exterior angle).
Kernel-verified through the tracked proof-search loop (episode f9f2334b).
-/

namespace MathCorpus.Elementary.Geometry

theorem exterior_angle (A B C : ℝ) (h : A + B + C = Real.pi) : A + B = Real.pi - C := by
  linarith

end MathCorpus.Elementary.Geometry
