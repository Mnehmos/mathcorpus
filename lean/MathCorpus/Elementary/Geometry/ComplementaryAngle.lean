import Mathlib
/-!
# Complementary angles

Packet: `elementary.geometry.complementary_angle.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

If two angles are complementary (sum to a right angle) then each is the right angle minus the other.
Kernel-verified through the tracked proof-search loop (episode 89547cdc).
-/

namespace MathCorpus.Elementary.Geometry

theorem complementary_angle (a b : ℝ) (h : a + b = Real.pi / 2) : a = Real.pi / 2 - b := by
  linarith

end MathCorpus.Elementary.Geometry
