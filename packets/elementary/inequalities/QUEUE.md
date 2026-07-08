# Queue — Inequalities (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 16 existing packets (2026-07-07) to avoid duplicates.

Per-packet history lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/inequalities/`; this file's "Done"
list previously grew an unbounded, repeatedly-headered bullet list
(matching the same growth pattern already fixed in the induction and
combinatorics dashboards this session) and has been condensed here.

## Done (condensed)

Named-inequality ladder (`L2_olympiad`): `am_gm_four_term`,
`nesbitt_three_var` (paired negative example:
`nesbitt_bare_nlinarith_division_failure.v1`), `schur_degree_one`,
`cauchy_three_term` (extends `cauchy_two_term` by one variable pair).

Absolute-value basics (`L0`/`L1`, added to offset the domain's
`L2_olympiad` skew): `abs_add_le`, `abs_add_three`, `abs_sub_le` (metric
triangle inequality), `abs_abs_sub_abs_le` (full doubly-absolute reverse
triangle inequality, strengthening the one-sided `reverse_triangle`).

Power-mean extension: `three_var_qm_am_bound` (extends `qm_am_bound`,
two-term case, to three variables).

Min/max family: `avg_between_min_max` (`min a b <= (a+b)/2 <= max a b`),
`min_add_min_le` (min is superadditive).

- [x] `max_add_le` — `max (a+b) (c+d) <= max a c + max b d` (D1, L1), i.e.
      max is subadditive; the dual companion to `min_add_min_le`. Authored
      2026-07-08 via tracked episode
      `a6eb2a43-9d19-427d-a2e3-bbc8c60dc9a7` (kernel_verified on the first
      attempt: `max_le`, `le_max_left`/`le_max_right`, closed by
      `linarith`).

- [x] `amgm_wrong_direction_counterexample` — explicit disproof (witness
      a=1, b=9) that the flipped AM-GM direction `(a+b)/2 <= sqrt(a*b)`
      is false in general. Authored 2026-07-08 via tracked episode
      `5c239fdd-ef5b-440d-b070-16de9d7d95c0` (kernel_verified on the first
      attempt). Paired negative example
      `negative.inequalities.amgm_wrong_direction_bare_nlinarith_failure.v1`
      (episode `ade3dee6-5a63-4a59-bf1a-0ec4e86c89aa`) resolves the
      queued "AM-GM in the wrong direction" candidate in
      `packets/negative/inequalities/QUEUE.md`.

- [x] `general_amgm` — the general unweighted n-term AM-GM inequality
      over an arbitrary nonempty `Finset`, `(∏ i ∈ s, z i)^(s.card⁻¹) <=
      (∑ i ∈ s, z i) / s.card` (L2/L3). Landed by a concurrent agent
      instance (2026-07-08, episode `71fafcd9-0ab6-4498-b785-b8bd96d5dc5a`,
      commit `d4784ca`) — this backlog item is now done; this file just
      hadn't been updated to reflect it yet.

- [x] `am_hm_two` — the AM-HM inequality (two-term case), `2/(1/a+1/b) <=
      (a+b)/2` (D1, L1). Authored 2026-07-08 via tracked episode
      `62654695-cd9d-4331-9466-55ad49a5c5f3` (kernel_verified on the
      second attempt). Completes the domain's power-mean chain (QM >= AM
      >= GM >= HM) — `qm_am_bound` covers QM-AM, `am_gm_two`/
      `general_amgm` cover AM-GM, and this was the missing AM-HM link;
      confirmed via `grep -rl harmonic` (no prior hits) before authoring.
      First attempt used `div_le_div_iff`, which no longer exists under
      that bare name in this Mathlib revision (renamed `div_le_div_iff₀`
      for the GroupWithZero-generalized lemma family) —
      `mathlib_search_declarations` surfaced the current name.

- [x] `general_cauchy_schwarz` — the general n-term Cauchy-Schwarz
      inequality over an arbitrary `Finset`, `(∑ i∈s, a i*b i)^2 <=
      (∑ i∈s, (a i)^2) * (∑ i∈s, (b i)^2)` (L2, D1). Authored 2026-07-08
      via tracked episode `fcb86396-6102-463a-91e3-726bf4f96594`
      (kernel_verified on the first attempt: a direct citation of
      Mathlib's `Finset.sum_mul_sq_le_sq_mul_sq`, found via
      `mathlib_search_declarations` before writing any proof attempt).
      Extends `cauchy_two_term`/`cauchy_three_term`'s fixed small arities
      to the general case, mirroring `general_amgm`'s prior extension of
      the AM-GM ladder.

- [x] `general_qm_am` — the general n-term QM-AM inequality (squared-sum
      form), `(∑ i∈s, f i)^2 <= |s| * ∑ i∈s, (f i)^2` (L2, D1). Authored
      2026-07-08 via tracked episode
      `0916c5cb-12e1-4e81-921e-82791b72684f` (kernel_verified on the
      second attempt: a direct citation of Mathlib's
      `sq_sum_le_card_mul_sum_sq`). Extends `qm_am_bound`/
      `three_var_qm_am_bound`'s fixed small arities, completing the same
      general-ladder pattern as `general_amgm`/`general_cauchy_schwarz`.
      First attempt tried the namespaced `Finset.sq_sum_le_card_mul_sum_sq`
      (matching the file it's declared in, `Chebyshev.lean`) and failed
      with "unknown constant" — the lemma is NOT actually under the
      `Finset` namespace; the bare name worked. Don't assume a
      Finset-indexed lemma lives in the `Finset` namespace.

- [x] `min_add_max` — the classic complementary equality
      `min(a,b)+max(a,b)=a+b` (D0, L1). Authored 2026-07-08 via tracked
      episode `5c58440d-825e-472c-b1ab-f9fa491ebfe5` (kernel_verified on
      the second attempt: `le_total` case split + `min_eq_left`/
      `max_eq_right` or `min_eq_right`/`max_eq_left`). Distinct from the
      domain's existing min/max INEQUALITIES (`avg_between_min_max`,
      `min_add_min_le`, `max_add_le`) — confirmed via
      `mathlib_search_declarations` (no `min_add_max`/`max_add_min` hits)
      before authoring. First attempt used `simp` for both case-split
      branches, which left a trivial `b+a=a+b` unsolved in one branch —
      switched to `rw` + a trailing `ring` to close the residual
      commutativity goal.

## Next targets

*(empty — see Backlog.)*

## Backlog

*(empty — repopulate from `LOOP.md`'s domain focus: named inequalities,
absolute value, min/max, power means, AM-GM/Cauchy/Schur family members
not yet covered. v0.1's numeric release criteria (>=250 public, >=25
negative) were both met this session — remaining work here is for
quality/balance, not raw count. Check `git log --oneline -15 --
packets/elementary/inequalities/` before starting a new target, since
concurrent agents work this domain too.)*
