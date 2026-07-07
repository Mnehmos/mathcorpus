import Mathlib
/-!
# Parallelogram law in coordinates

Packet: `elementary.geometry.parallelogram_law.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

For plane vectors u=(a,b) and v=(c,d), |u+v|^2 + |u-v|^2 = 2|u|^2 + 2|v|^2.
Kernel-verified through the tracked proof-search loop (episode d8aabf90).
-/

namespace MathCorpus.Elementary.Geometry

theorem parallelogram_law (a b c d : ℝ) : (a + c) ^ 2 + (b + d) ^ 2 + ((a - c) ^ 2 + (b - d) ^ 2) = 2 * (a ^ 2 + b ^ 2) + 2 * (c ^ 2 + d ^ 2) := by
  ring

end MathCorpus.Elementary.Geometry
