# Dashboard — Inequalities (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 19 |
| Level breakdown | L0_elementary: 2 · L1_proof_basics: 2 · L2_olympiad: 15 |

Last synced: 2026-07-08 — added `nesbitt_three_var` (D2, L2, episode
`f300e689-9670-45f4-8454-47e4e80b73ac`): the named olympiad inequality
`a/(b+c)+b/(a+c)+c/(a+b) >= 3/2`, proved by clearing denominators
(`div_add_div` ×2 + `le_div_iff₀`) then `nlinarith` with square/positivity
hints; paired negative example
`packets/negative/inequalities/nesbitt_bare_nlinarith_division_failure.v1.json`
captures the bare-nlinarith-on-division failure that preceded it in the
same episode. Also present from a concurrent agent: `am_gm_four_term`
(episode `26c22232-4518-4edc-9c11-b63813cf670f`). Also added
`schur_degree_one` (D2, L2, episode
`cbffe931-b879-4d09-b98e-1394e26a4e30`): Schur's inequality (t=1) for
nonnegative reals, proved via an 8-way ordering case split
(`le_total` ×3) closed uniformly by one `nlinarith` call with product/
square hints. Re-sync against `agents/status/MATHCORPUS_STATUS.md` and
`python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
