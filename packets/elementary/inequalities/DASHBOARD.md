# Dashboard — Inequalities (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 31 |
| Level breakdown | L0_elementary: 6 · L1_proof_basics: 8 · L2_olympiad: 17 |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/inequalities/`; re-condensed this
cycle (same recurring growth pattern fixed previously in this file and in
induction/combinatorics). Highlights: this domain started heavily skewed
toward `L2_olympiad` named inequalities (AM-GM ladder, Nesbitt, Schur,
Cauchy-Schwarz); recent cycles have deliberately added `L0`/`L1` content
to offset that: absolute-value basics (`abs_add_le`, `abs_add_three`,
`abs_sub_le`, `abs_abs_sub_abs_le`), power-mean extensions
(`three_var_qm_am_bound`), a growing min/max family (`avg_between_min_max`,
`min_add_min_le`, `max_add_le`), `amgm_wrong_direction_counterexample`
(explicit disproof, witness a=1, b=9, that the flipped AM-GM direction is
false, paired with the negative example
`amgm_wrong_direction_bare_nlinarith_failure` — the lane's first
`false_generalization`-category negative example), `general_amgm` (the
full n-term unweighted AM-GM over an arbitrary nonempty `Finset`), and
this cycle's `am_hm_two` (D1, L1, episode `62654695`): the AM-HM
inequality, completing the domain's power-mean chain (QM >= AM >= GM >=
HM) alongside `qm_am_bound`/`am_gm_two`/`general_amgm`.

Next targets: see `QUEUE.md`.
