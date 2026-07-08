# Queue — Induction (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
**This domain is the smallest in the corpus (6 packets) — prioritize it
over other elementary domains when otherwise unconstrained**, per
`agents/status/MATHCORPUS_STATUS.md`.

## Next targets

- [ ] `bernoulli_inequality` — `(1 + x) ^ n >= 1 + n * x` for `x >= -1`
      (D1, L1). A textbook induction-by-tactic example; also a natural
      cross-domain link to `packets/elementary/inequalities/`.
- [ ] `two_pow_gt_self` — `2 ^ n > n` for all `n` (D0, L0). One of the
      simplest genuine induction proofs; good low-difficulty addition given
      the domain's small size.
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
