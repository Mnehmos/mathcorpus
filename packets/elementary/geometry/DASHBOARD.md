# Dashboard — Geometry (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 34 |
| Level breakdown | L0_elementary: 5 · L1_proof_basics: 26 · L2_olympiad: 3 |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/geometry/`; this file previously
grew an unbounded per-packet bullet list and has been condensed (same fix
already applied across combinatorics/induction/inequalities/functions
this session). Highlights: `pythagorean_right_angle` (paired negative
example `pythagorean_bare_ring_no_hypothesis_failure`),
`circle_point_dist_eq_radius` (the domain's first circle-equation
packet), `reflection_over_x_axis`, and this cycle's
`right_triangle_area_half_base_height` (squared-form area-via-base-and-
height for a right triangle, via the Lagrange identity). This domain
consistently avoids `Real.sqrt` in favor of squared-distance formulas
(see `midpoint_equidist`, `reflection_dist`) — follow that convention for
new area/distance/circle packets.

Next targets: see `QUEUE.md`.
