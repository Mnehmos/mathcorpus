# Queue — Geometry (Negative Examples)

This domain has 3 negative packets now (`angle_atoms_nlinarith_failure.v1.json`,
`pythagorean_bare_ring_no_hypothesis_failure.v1.json`,
`slope_div_mul_division_by_zero_unguarded.v1.json`). Add a **distinct**
failure category rather than a near-duplicate.

## Next targets

*(empty — see Backlog)*

## Backlog

- [ ] `field_simp`/`ring` mismatch on a coordinate-geometry goal mixing
      `EuclideanSpace` inner-product notation with raw coordinate algebra
      (verify a concrete instance before adding).

## Completed

- [x] **bare `ring` on a hypothesis-dependent Pythagorean identity.**
      `pythagorean_bare_ring_no_hypothesis_failure.v1.json` — `ring` on the
      squared-distance Pythagorean goal (true only given the right-angle
      dot-product hypothesis `h`) leaves an `unsolved_goals` residual since
      `ring` never consults hypotheses; `nlinarith [h]` closes the same
      tracked episode `kernel_verified` as
      `packets/elementary/geometry/pythagorean_right_angle.v1.json`.
      episode `1ee45ae1-bde1-4cfa-bd4a-68261f9f8fb1`.
- [x] **Unguarded division by zero in a slope formula.**
      `slope_div_mul_division_by_zero_unguarded.v1.json` — `field_simp`
      correctly leaves `(y2-y1)/(x2-x1)*(x2-x1) = y2-y1` unsolved (no
      `x2 ≠ x1` hypothesis); falseness kernel-verified separately via
      witness `x1=x2=0, y1=0, y2=5` in the companion positive packet
      `elementary.geometry.slope_div_mul_not_always_cancel.v1`. Verified
      live via tracked episodes `2409c443-...` (failed attempt) and
      `9d78c78c-...` (kernel_verified disproof), 2026-07-08.
