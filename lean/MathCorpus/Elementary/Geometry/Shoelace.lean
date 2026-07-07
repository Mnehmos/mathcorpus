import Mathlib
/-!
# Shoelace identity for twice the signed triangle area

Packet: `elementary.geometry.shoelace_identity.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The cross-product form of twice the signed area of a triangle equals its shoelace sum.
Kernel-verified through the tracked proof-search loop (episode c0f62a65).
-/

namespace MathCorpus.Elementary.Geometry

theorem shoelace_identity (x1 y1 x2 y2 x3 y3 : ℝ) : (x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1) = x1 * y2 - x2 * y1 + (x2 * y3 - x3 * y2) + (x3 * y1 - x1 * y3) := by
  ring

end MathCorpus.Elementary.Geometry
