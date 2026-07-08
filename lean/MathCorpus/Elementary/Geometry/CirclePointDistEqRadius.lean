import Mathlib
/-!
# Cosine/sine parametrization lies on the circle

Packet: `elementary.geometry.circle_point_dist_eq_radius.v1`
Level:  L0_elementary · Domain: geometry · Trust rung 1 (Lean kernel).

The point (cx + r*cos(theta), cy + r*sin(theta)) has squared distance r^2 from the
center (cx, cy), for every angle theta. Phrased with squared distance to match this
domain's existing convention (midpoint_equidist, reflection_dist avoid Real.sqrt).
Kernel-verified through the tracked proof-search loop (episode d3dedd8a).
-/

namespace MathCorpus.Elementary.Geometry

theorem circle_point_dist_eq_radius :
    ∀ (cx cy r θ : ℝ),
      (cx + r * Real.cos θ - cx) ^ 2 + (cy + r * Real.sin θ - cy) ^ 2 = r ^ 2 := by
  intro cx cy r θ
  have h : Real.sin θ ^ 2 + Real.cos θ ^ 2 = 1 := Real.sin_sq_add_cos_sq θ
  nlinarith [h]

end MathCorpus.Elementary.Geometry
