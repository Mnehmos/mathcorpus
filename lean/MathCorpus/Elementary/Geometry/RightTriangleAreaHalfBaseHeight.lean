import Mathlib
/-!
# Right-triangle area via base and height (squared form)

Packet: `elementary.geometry.right_triangle_area_half_base_height.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

For a triangle with vertices A, B, C where the angle at B is a right angle (the dot
product of BA and BC is zero), the square of twice the signed area (the shoelace
cross-product term) equals the product of the squared leg lengths |BA|^2 * |BC|^2 --
the squared form of Area = (1/2) * base * height, avoiding Real.sqrt to match this
domain's convention (shoelace_identity, pythagorean_right_angle). Follows from the
unconditional Lagrange identity |u|^2|v|^2 - (u.v)^2 = (cross u v)^2 specialized to
the right-angle case dot = 0.
Kernel-verified through the tracked proof-search loop (episode db18efdb).
-/

namespace MathCorpus.Elementary.Geometry

theorem right_triangle_area_half_base_height (ax ay bx by1 cx cy : ℝ)
    (h : (ax - bx) * (cx - bx) + (ay - by1) * (cy - by1) = 0) :
    ((ax - bx) * (cy - by1) - (cx - bx) * (ay - by1)) ^ 2 =
      ((ax - bx) ^ 2 + (ay - by1) ^ 2) * ((cx - bx) ^ 2 + (cy - by1) ^ 2) := by
  linear_combination (-(ax - bx) * (cx - bx) - (ay - by1) * (cy - by1)) * h

end MathCorpus.Elementary.Geometry
