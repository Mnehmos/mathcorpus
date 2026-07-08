# Queue — Geometry (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 29 existing packets (2026-07-07) to avoid duplicates.

## Done

- [x] `pythagorean_right_angle` — for a right angle at `B`, squared
      distance A-to-C equals squared distance A-to-B plus squared distance
      B-to-C (D1, L1). Authored 2026-07-08 via tracked episode
      `1ee45ae1-bde1-4cfa-bd4a-68261f9f8fb1` (kernel_verified:
      `nlinarith [h]` from the right-angle dot-product hypothesis). A bare
      `ring` attempt kernel-failed first in the same episode (ring cannot
      use hypotheses) and is preserved as
      `packets/negative/geometry/pythagorean_bare_ring_no_hypothesis_failure.v1.json`.
      Fills the curriculum-notable Pythagorean-theorem gap.

## Done (continued)

- [x] `circle_point_dist_eq_radius` — the cosine/sine parametrization
      `(cx + r*cos(theta), cy + r*sin(theta))` has squared distance `r^2`
      from the center `(cx, cy)` (D0, L0). Authored 2026-07-08 via tracked
      episode `d3dedd8a-5919-404f-baf4-3952a49bb159` (kernel_verified on
      the first attempt: `Real.sin_sq_add_cos_sq θ` + `nlinarith [h]`).
      Phrased with squared distance (not `dist p c = r` / `Real.sqrt`) to
      match this domain's convention (`midpoint_equidist`,
      `reflection_dist`); the domain's first circle-equation packet.

## Done (continued)

- [x] `reflection_over_x_axis` — coordinate reflection `(x, y) -> (x, -y)`
      preserves squared distance to any point `(qx, 0)` on the x-axis (D0,
      L0). Authored 2026-07-08 via tracked episode
      `66dcb53d-d77c-4467-ad54-bdf0db0008a6` (kernel_verified: `ring`, an
      unconditional polynomial identity once the axis point's y-coordinate
      is fixed at 0 in the statement). A first `problem_create` without an
      explicit `problem_imports: ["Mathlib"]` resolved to a bare
      Ring+NormNum manifest and hit a spurious `HSub ℝ ℝ ?m` typeclass
      failure on the identical tactic — a tooling/import-manifest artifact
      (not a genuine tactic lesson), fixed by re-registering with the
      standard `["Mathlib"]` import manifest used by every other packet in
      this repo.

## Next targets

- [ ] `right_triangle_area_half_base_height` — area of a right triangle via
      the two legs (D1, L1). `shoelace_identity` gives the general-triangle
      area formula; the right-triangle special case is a good, smaller
      companion.

## Backlog

- [ ] Law of cosines (L2 — natural next step after `triangle_angle_sum` and
      `dist_sq_expand`, ties into `GeometryAngleKit`).
- [ ] Law of sines (L2, companion to law of cosines).
