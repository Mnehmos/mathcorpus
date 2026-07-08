# Dashboard — Geometry (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 37 |
| Level breakdown | L0_elementary: 6 · L1_proof_basics: 28 · L2_olympiad: 3 |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/geometry/`; this file previously
grew an unbounded per-packet bullet list and has been condensed (same fix
already applied across combinatorics/induction/inequalities/functions
this session). Highlights: `pythagorean_right_angle` (paired negative
example `pythagorean_bare_ring_no_hypothesis_failure`),
`circle_point_dist_eq_radius` (the domain's first circle-equation
packet), `reflection_over_x_axis`, `right_triangle_area_half_base_height`
(squared-form area-via-base-and-height for a right triangle, via the
Lagrange identity), `law_of_cosines` (coordinate/squared-distance form),
and this cycle's `apollonius_median` (median length theorem,
AB^2+AC^2 = 2*AM^2+2*BM^2 — pure `ring`, reuses the `midpoint_equidist`
pattern). This domain consistently avoids `Real.sqrt` in favor of
squared-distance formulas (see `midpoint_equidist`, `reflection_dist`) —
follow that convention for new area/distance/circle packets. Law of
sines was investigated and deliberately deferred this cycle for exactly
this reason — see `QUEUE.md`'s Backlog entry. And this cycle's
`reflection_over_y_axis` (D0, L0, episode `ecc942d6`): the y-axis
companion to `reflection_over_x_axis`, closing a real symmetry gap
(only the x-axis case existed before).

Next targets: see `QUEUE.md`.
