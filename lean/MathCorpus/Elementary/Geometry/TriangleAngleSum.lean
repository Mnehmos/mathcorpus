import Mathlib
/-!
# Triangle angle sum (scalar form)

Packet: `elementary.geometry.triangle_angle_sum.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

If the three angles of a triangle sum to π, the third angle equals π minus the other two.
Kernel-verified through the tracked proof-search loop (episode 5e6ab2e5).
-/

namespace MathCorpus.Elementary.Geometry

theorem triangle_angle_sum (A B C : ℝ) (h : A + B + C = Real.pi) : C = Real.pi - A - B := by
  linarith

end MathCorpus.Elementary.Geometry
