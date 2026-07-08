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
fine — renamed to `by1` and retried. `law_of_cosines` (coordinate/
squared-distance form, episode `d1f31293`) landed via a concurrent agent
instance — this backlog wasn't updated at the time, so a later cycle
re-discovered it already done; check `ls packets/elementary/geometry/`
directly, not just this file, before starting a backlog item.
`apollonius_median` (median length theorem: AB^2+AC^2 = 2*AM^2+2*BM^2,
episode `d56cbb06`) — pure coordinate `ring` identity, same style as
`midpoint_equidist`; first `problem_create` attempt omitted
`problem_imports` and defaulted to a Ring+NormNum-only manifest that
doesn't resolve `ℝ`, causing autoImplicit to silently swallow it as an
abstract type and a spurious `HSub` instance-synthesis failure —
re-registered with `problem_imports: ["Mathlib"]` (same fix as
`law_of_cosines`'s own note) and it went through immediately.

- [x] `reflection_over_y_axis` — the y-axis companion to
      `reflection_over_x_axis` (D0, L0). Authored 2026-07-08 via tracked
      episode `ecc942d6-2c5b-47d0-bae7-2d9e608a4074` (kernel_verified on
      the first attempt: pure `ring`). Confirmed via `grep -rl y_axis`
      (no prior hits) before authoring — only the x-axis case existed.

## Next targets

*(empty — see Backlog.)*

## Backlog

- [ ] Law of sines (L2) — **investigated 2026-07-08, deferred, not a
      one-cycle target.** Unlike `law_of_cosines` (a pure algebraic
      identity that only reuses the SAME angle already given as a
      parameter), a faithful law of sines needs the sine of a SECOND,
      independently-defined triangle angle (e.g. the angle at vertex B,
      derived from vectors BA/BC via a dot-product-based arccos or an
      area/cross-product ratio). Every route into that requires either
      Mathlib's `EuclideanGeometry`/`InnerProductGeometry.angle` API
      (not used anywhere else in this domain yet — would be a new
      dependency, not a drop-in) or reintroducing `Real.sqrt`/division
      over side lengths, which this domain's packets deliberately avoid
      (see `DASHBOARD.md`'s sqrt-avoidance note and the recorded
      `Real.sqrt` atom-matching pitfall from `quad_formula_real_root` in
      `inequalities`/`algebra`). `mathlib_search_declarations` found no
      existing `law_sin`/`law_cos` Mathlib lemma to wrap either — confirms
      `law_of_cosines` itself was a from-scratch derivation, not a
      Mathlib transport. Scope for a dedicated future cycle that first
      lands `InnerProductGeometry.angle`-based helper packets, not a
      same-cycle pickup.
