import Mathlib
/-!
# Dividing then multiplying back by (x2 - x1) does not always recover (y2 - y1)

Packet: `elementary.geometry.slope_div_mul_not_always_cancel.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

`(y2 - y1) / (x2 - x1) * (x2 - x1) = y2 - y1` is false in general: it only
holds when `x2 ≠ x1`. Witnessed here by `x1 = x2 = 0, y1 = 0, y2 = 5`,
where division by zero (Lean's `Field` convention) collapses the left
side to `0` while the right side stays `5`. Kernel-verified through the
tracked proof-search loop (episode 9d78c78c). Paired negative example:
`negative.geometry.slope_div_mul.division_by_zero_unguarded.v1` (the
natural first attempt to prove the unconditional claim directly via
`field_simp`).
-/

namespace MathCorpus.Elementary.Geometry

theorem slope_div_mul_not_always_cancel :
    ¬ (∀ x1 y1 x2 y2 : ℝ, (y2 - y1) / (x2 - x1) * (x2 - x1) = y2 - y1) := by
  intro h
  have h0 := h 0 0 0 5
  norm_num at h0

end MathCorpus.Elementary.Geometry
