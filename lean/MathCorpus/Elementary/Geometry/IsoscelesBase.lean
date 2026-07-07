import Mathlib
/-!
# Isosceles base angle

Packet: `elementary.geometry.isosceles_base_angle.v1`
Level:  L2_olympiad · Domain: geometry · Trust rung 1 (Lean kernel).

In an isosceles triangle the two equal base angles are each (pi - apex)/2.
Kernel-verified through the tracked proof-search loop (episode 50e06105).
-/

namespace MathCorpus.Elementary.Geometry

theorem isosceles_base_angle (apex base : ℝ) (h : apex + 2 * base = Real.pi) : base = (Real.pi - apex) / 2 := by
  linarith

end MathCorpus.Elementary.Geometry
