import Mathlib
/-!
# The midpoint is equidistant from both endpoints

Packet: `elementary.geometry.midpoint_between.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The midpoint is equidistant from both endpoints.
Kernel-verified through the tracked proof-search loop (episode 4ab61e5e).
-/

namespace MathCorpus.Elementary.Geometry

theorem midpoint_between : ∀ (a b : ℝ), (a + b) / 2 - a = b - (a + b) / 2 := by
  intro a b; ring

end MathCorpus.Elementary.Geometry
