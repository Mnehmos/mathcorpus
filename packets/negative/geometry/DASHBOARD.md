# Dashboard — Geometry (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 3 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

Packets:

- `angle_atoms_nlinarith_failure.v1.json` — `nlinarith` over raw
  `EuclideanGeometry.angle` atoms is a deterministic budget-burner.
- `pythagorean_bare_ring_no_hypothesis_failure.v1.json` — bare `ring` on a
  hypothesis-dependent Pythagorean identity leaves an `unsolved_goals`
  residual; `nlinarith [h]` closes the same tracked episode
  (`1ee45ae1-bde1-4cfa-bd4a-68261f9f8fb1`) `kernel_verified`.
- `slope_div_mul_division_by_zero_unguarded.v1.json` — first
  `false_generalization`-category example for this domain: `field_simp`
  correctly leaves `(y2-y1)/(x2-x1)*(x2-x1) = y2-y1` unsolved (no
  `x2 ≠ x1` hypothesis to justify the cancellation), because the claim is
  genuinely false at `x1 = x2`. Tracked episode
  `2409c443-59dd-40d6-8d7a-71ae56a395cf`; falseness separately
  kernel-verified via witness `x1=x2=0, y1=0, y2=5` in the companion
  positive packet `elementary.geometry.slope_div_mul_not_always_cancel.v1`
  (episode `9d78c78c-35de-4af4-89b8-bac682026fc1`).

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
