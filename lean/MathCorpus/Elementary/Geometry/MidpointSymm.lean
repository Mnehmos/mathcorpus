import Mathlib
/-!
# Midpoint is symmetric in endpoints

Packet: `elementary.geometry.midpoint_symm.v1`
Level:  L0_elementary · Domain: geometry · Trust rung 1 (Lean kernel).

The midpoint of a segment does not depend on the order of the endpoints.
Kernel-verified through the tracked proof-search loop (episode b5909c13).
-/

namespace MathCorpus.Elementary.Geometry

theorem midpoint_symm (a c : ℝ) : (a + c) / 2 = (c + a) / 2 := by
  ring

end MathCorpus.Elementary.Geometry
