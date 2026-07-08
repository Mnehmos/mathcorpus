# Dashboard — Inequalities (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 21 |
| Level breakdown | L0_elementary: 4 · L1_proof_basics: 2 · L2_olympiad: 15 |

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
square hints. Also added `abs_add_le` (D0, L0, episode
`0c084674-3e97-422a-bff1-f5c906e0bc78`): the real triangle inequality
`|a+b| <= |a|+|b|`, proved by an 8-way sign case split (`abs_cases` on
`a`, `b`, `a+b`) closed uniformly by `nlinarith` — this domain's first
genuinely elementary absolute-value packet, deliberately picked to offset
the domain's L2_olympiad skew (15 of 19 packets before this one). Needed
`Mathlib.Data.Real.Basic` in `problem_imports` alongside
`Mathlib.Algebra.Order.Group.Abs`; the latter alone is missing ℝ's own
ring/lattice/order instances. Also added `abs_add_three` (D0, L0, episode
`00c6c1c7-af24-448f-bb93-1e1944e1791a`): the three-term extension
`|a+b+c| <= |a|+|b|+|c|`, proved by the same `abs_cases`-based case-split
technique (16 branches, `nlinarith` uniformly). Re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
