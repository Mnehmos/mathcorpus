import Mathlib
/-!
# Apollonius's theorem (median length theorem)

Packet: `elementary.geometry.apollonius_median.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

For a triangle with vertices A, B, C and M the midpoint of side BC,
AB^2 + AC^2 = 2*AM^2 + 2*BM^2.
Kernel-verified through the tracked proof-search loop (episode d56cbb06).
-/

namespace MathCorpus.Elementary.Geometry

theorem apollonius_median (xA yA xB yB xC yC : ℝ) :
    (xA - xB) ^ 2 + (yA - yB) ^ 2 + ((xA - xC) ^ 2 + (yA - yC) ^ 2) =
    2 * ((xA - (xB + xC) / 2) ^ 2 + (yA - (yB + yC) / 2) ^ 2) +
    2 * ((xB - (xB + xC) / 2) ^ 2 + (yB - (yB + yC) / 2) ^ 2) := by
  ring

end MathCorpus.Elementary.Geometry
