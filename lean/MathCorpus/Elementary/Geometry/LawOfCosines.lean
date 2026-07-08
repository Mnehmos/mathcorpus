import Mathlib

/-!
# Law of cosines (coordinate / squared-distance form)

Packet: `elementary.geometry.law_of_cosines.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Place one triangle vertex at the origin, a second at (b, 0), and the third
at (a*cos θ, a*sin θ), where θ is the angle at the origin between the two
sides of length a and b. The squared distance from the second vertex
(b, 0) to the third vertex equals a^2 + b^2 - 2*a*b*cos θ -- the law of
cosines, phrased in this domain's established coordinate/squared-distance
style (matches `circle_point_dist_eq_radius`'s cos/sin parametrization).
Kernel-verified through the tracked proof-search loop (episode d1f31293).
-/

namespace MathCorpus.Elementary.Geometry

theorem law_of_cosines (a b θ : ℝ) :
    (a * Real.cos θ - b) ^ 2 + (a * Real.sin θ) ^ 2 =
      a ^ 2 + b ^ 2 - 2 * a * b * Real.cos θ := by
  nlinarith [Real.sin_sq_add_cos_sq θ]

end MathCorpus.Elementary.Geometry
