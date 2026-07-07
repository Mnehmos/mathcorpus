import Mathlib
/-!
# Section formula (1:2 division point)

Packet: `elementary.geometry.section_formula_thirds.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Tripling the 1:2 internal-division coordinate recovers the weighted vertex sum.
Kernel-verified through the tracked proof-search loop (episode 4d4edbca).
-/

namespace MathCorpus.Elementary.Geometry

theorem section_formula_thirds (x1 x2 : ℝ) : 3 * ((x1 + 2 * x2) / 3) = x1 + 2 * x2 := by
  ring

end MathCorpus.Elementary.Geometry
