import Mathlib
/-!
# The perpendicularity condition on slopes is symmetric

Packet: `elementary.geometry.perp_slopes_comm.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The perpendicularity condition on slopes is symmetric.
Kernel-verified through the tracked proof-search loop (episode 47dbeaba).
-/

namespace MathCorpus.Elementary.Geometry

theorem perp_slopes_comm : ∀ (m1 m2 : ℝ), m1 * m2 = -1 → m2 * m1 = -1 := by
  intro m1 m2 h; rw [mul_comm m2 m1]; exact h

end MathCorpus.Elementary.Geometry
