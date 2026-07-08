# Queue — Geometry (Elementary)

Candidate packets to create or formalize next, roughly in priority order.

Per-packet history lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/geometry/`; this file's "Done"
list previously grew an unbounded, repeatedly-headered bullet list
(matching the same growth pattern already fixed elsewhere this session)
and has been condensed here.

## Done (condensed)

`pythagorean_right_angle` (paired negative example:
`pythagorean_bare_ring_no_hypothesis_failure` — bare `ring` can't use
hypotheses, `nlinarith [h]` closes it), `circle_point_dist_eq_radius`
(the domain's first circle-equation packet, cosine/sine parametrization),
`reflection_over_x_axis`, `right_triangle_area_half_base_height` — squared
form of Area = (1/2)*base*height via the Lagrange identity
(`linear_combination`); note: an initial attempt used `by` as a
y-coordinate variable name and collided with Lean's `by` keyword, causing
a parse error in the proof term despite the root statement registering
fine — renamed to `by1` and retried.

## Next targets

*(empty — see Backlog.)*

## Backlog

- [ ] Law of cosines (L2 — natural next step after `triangle_angle_sum` and
      `dist_sq_expand`, ties into `GeometryAngleKit`).
- [ ] Law of sines (L2, companion to law of cosines).
