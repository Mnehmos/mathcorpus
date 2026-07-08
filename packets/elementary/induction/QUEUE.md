# Queue — Induction (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
**This domain is the smallest in the corpus (8 packets) — prioritize it
over other elementary domains when otherwise unconstrained**, per
`agents/status/MATHCORPUS_STATUS.md`.

## Done

- [x] `two_pow_gt_self` — `n < 2 ^ n` for all `n` (D0, L0). Authored
      2026-07-08 via tracked episode `5a175c43-1c93-4cf7-a4e9-5038e1961068`
      (kernel_verified: `induction n with | zero => norm_num | succ n ih =>
      rw [pow_succ]; nlinarith [ih]`). The naive `nlinarith [ih]` attempt
      (no `pow_succ` rewrite) kernel-failed first in the same episode and is
      preserved as
      `packets/negative/induction/pow_succ_atom_nlinarith_failure.v1.json`.
- [x] `bernoulli_inequality` — `1 + n*x <= (1+x)^n` for `x >= -1` (D1, L1).
      Authored 2026-07-08 via tracked episode
      `344364cb-791a-4e8a-9f5e-be0cc95210de` (kernel_verified on the first
      attempt: `induction n`, `mul_le_mul_of_nonneg_right ih hx'` +
      `sq_nonneg x` as nlinarith hints). Uses `InequalityEstimateKit`
      (recorded in `CROSS_DOMAIN.md`); cross-references
      `packets/elementary/inequalities/`.

## Next targets

- [ ] `sum_evens` — `∑ i in range n, 2 * i = n * (n - 1)` (D0/D1, L0/L1).
      The domain already has `sum_odds`; the evens companion is a natural,
      cheap addition.
- [ ] `geom_series_sum_induction` — closed form for `∑ i in range n, r ^ i`
      proved **by induction** (D1, L1) — distinct proof style from
      `packets/elementary/functions/geom_series_mul` (a factorization
      identity, not an inductive proof); cross-reference both once authored.
- [ ] `factorial_ge_two_pow` — `n ! >= 2 ^ (n - 1)` for `n >= 1` (D1, L1).
      Builds on `factorial_pos'` / `factorial_le'` already in
      `packets/elementary/number_theory/`; record the cross-domain
      dependency in `CROSS_DOMAIN.md` when authored.

## Backlog

- [ ] Strong induction example: every `n >= 2` has a prime factor (L1/L2 —
      ties to the number_theory domain's planned `prime_two` /
      `not_prime_one` packets; author those first).
