import Mathlib
/-!
# Expansion of the squared distance

Packet: `elementary.geometry.distance_expand.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The squared distance expands into the standard quadratic form.
Kernel-verified through the tracked proof-search loop (episode 5fbdba3e).
-/

namespace MathCorpus.Elementary.Geometry

theorem distance_expand (x1 y1 x2 y2 : ℝ) : (x2 - x1) ^ 2 + (y2 - y1) ^ 2 = x2 ^ 2 - 2 * x1 * x2 + x1 ^ 2 + (y2 ^ 2 - 2 * y1 * y2 + y1 ^ 2) := by
  ring

end MathCorpus.Elementary.Geometry
