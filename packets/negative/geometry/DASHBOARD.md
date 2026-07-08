# Dashboard — Geometry (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 2 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

Packets:

- `angle_atoms_nlinarith_failure.v1.json` — `nlinarith` over raw
  `EuclideanGeometry.angle` atoms is a deterministic budget-burner.
- `pythagorean_bare_ring_no_hypothesis_failure.v1.json` — bare `ring` on a
  hypothesis-dependent Pythagorean identity leaves an `unsolved_goals`
  residual; `nlinarith [h]` closes the same tracked episode
  (`1ee45ae1-bde1-4cfa-bd4a-68261f9f8fb1`) `kernel_verified`.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
