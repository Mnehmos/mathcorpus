# Queue — Geometry (Negative Examples)

This domain has 2 negative packets now (`angle_atoms_nlinarith_failure.v1.json`,
`pythagorean_bare_ring_no_hypothesis_failure.v1.json`). Add a **distinct**
failure category rather than a near-duplicate.

## Next targets

- [ ] **Unguarded division by zero in a slope formula.** Attempt a slope
      identity `(y2 - y1) / (x2 - x1) = ...` without the hypothesis
      `x1 ≠ x2`. Expected failure mode: the statement is either false or
      vacuously ill-typed at `x1 = x2` (division by zero returns `0` in
      Lean's `Field`, which silently makes the "identity" false at that
      point) — a genuinely different category from the existing
      `nlinarith`-timeout example. gap_category: `false_generalization`,
      sub_category: `division_by_zero_unguarded`. Note the existing
      `perp_slopes_comm` packet for how the domain currently handles slope
      hypotheses, to avoid contradicting it.

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
