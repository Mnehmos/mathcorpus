import Mathlib
/-!
# Three times the centroid coordinate recovers the coordinate sum

Packet: `elementary.geometry.centroid_x.v1`
Level:  L0_elementary · Domain: geometry · Trust rung 1 (Lean kernel).

Three times the centroid coordinate recovers the coordinate sum.
Kernel-verified through the tracked proof-search loop (episode 2648b380).
-/

namespace MathCorpus.Elementary.Geometry

theorem centroid_x : ∀ (a b c : ℝ), (a + b + c) / 3 * 3 = a + b + c := by
  intro a b c; ring

end MathCorpus.Elementary.Geometry
