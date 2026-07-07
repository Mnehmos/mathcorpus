import Mathlib
/-!
# Doubling a bisected angle

Packet: `elementary.geometry.angle_bisector_double.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Twice the bisected half-angle recovers the original angle.
Kernel-verified through the tracked proof-search loop (episode 73361c37).
-/

namespace MathCorpus.Elementary.Geometry

theorem angle_bisector_double (θ : ℝ) : 2 * (θ / 2) = θ := by
  ring

end MathCorpus.Elementary.Geometry
