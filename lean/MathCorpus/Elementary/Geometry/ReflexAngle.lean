import Mathlib
/-!
# An angle plus its reflex is a full turn

Packet: `elementary.geometry.reflex_angle.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

An angle and its reflex angle sum to a full turn (2 pi).
Kernel-verified through the tracked proof-search loop (episode 7e9d24a6).
-/

namespace MathCorpus.Elementary.Geometry

theorem reflex_angle (θ : ℝ) : θ + (2 * Real.pi - θ) = 2 * Real.pi := by
  ring

end MathCorpus.Elementary.Geometry
