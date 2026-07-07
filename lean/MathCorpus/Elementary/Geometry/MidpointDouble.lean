import Mathlib
/-!
# Doubling the midpoint coordinate

Packet: `elementary.geometry.midpoint_double.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Twice the midpoint coordinate equals the sum of the endpoint coordinates.
Kernel-verified through the tracked proof-search loop (episode 6c049691).
-/

namespace MathCorpus.Elementary.Geometry

theorem midpoint_double (x1 x2 : ℝ) : 2 * ((x1 + x2) / 2) = x1 + x2 := by
  ring

end MathCorpus.Elementary.Geometry
