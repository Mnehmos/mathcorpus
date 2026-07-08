# Queue — Geometry (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 29 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `pythagorean_right_angle` — for a right angle at `B`, `dist A C ^ 2 =
      dist A B ^ 2 + dist B C ^ 2` (D1, L1). The domain has
      `dist_sq_expand`, `distance_sq_nonneg`, and `triangle_angle_sum` but
      no explicit Pythagorean-theorem packet — a curriculum-notable gap.
- [ ] `circle_point_dist_eq_radius` — a point on a circle of center `c` and
      radius `r` satisfies `dist p c = r` (D0, L0). No circle-equation
      packet exists yet; pairs naturally with the existing
      `midpoint_equidist`.
- [ ] `right_triangle_area_half_base_height` — area of a right triangle via
      the two legs (D1, L1). `shoelace_identity` gives the general-triangle
      area formula; the right-triangle special case is a good, smaller
      companion.
- [ ] `reflection_over_x_axis` — coordinate reflection `(x, y) -> (x, -y)`
      preserves distance to any point on the axis (D0, L0). The existing
      `reflection_dist` is more general/abstract; a concrete coordinate
      instance is still missing and is a good D0 on-ramp.

## Backlog

- [ ] Law of cosines (L2 — natural next step after `triangle_angle_sum` and
      `dist_sq_expand`, ties into `GeometryAngleKit`).
- [ ] Law of sines (L2, companion to law of cosines).
