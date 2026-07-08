# Dashboard — Geometry (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 31 |
| Level breakdown | L0_elementary: 4 · L1_proof_basics: 24 · L2_olympiad: 3 |

Last synced: 2026-07-08 — added `pythagorean_right_angle` (D1, L1, episode
`1ee45ae1-bde1-4cfa-bd4a-68261f9f8fb1`): squared-distance Pythagorean
theorem from a right-angle dot-product hypothesis, via `nlinarith [h]`;
paired negative example
`packets/negative/geometry/pythagorean_bare_ring_no_hypothesis_failure.v1.json`
captures the bare-`ring`-ignores-hypotheses failure that preceded it in
the same episode. Also added `circle_point_dist_eq_radius` (D0, L0,
episode `d3dedd8a-5919-404f-baf4-3952a49bb159`): the cosine/sine
parametrization of a circle has squared distance r^2 from the center, via
`Real.sin_sq_add_cos_sq` + `nlinarith`; the domain's first circle-equation
packet. Re-sync against `agents/status/MATHCORPUS_STATUS.md` and
`python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
