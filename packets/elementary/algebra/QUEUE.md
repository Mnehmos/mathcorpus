# Queue — Algebra (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 41 existing packets (2026-07-07) to avoid duplicates.

## Done (this cycle)

- [x] `pow_add` — `x ^ (m + n) = x ^ m * x ^ n` (D0, L0). Authored
      2026-07-08 via tracked episode `fa0521fa-5205-4059-9071-c5519c5f3392`
      (kernel_verified on the first attempt: `ring`).

- [x] `pow_mul` — `x ^ (m * n) = (x ^ m) ^ n` (D0, L0). Authored
      2026-07-08 via tracked episode `13c20f38-d366-44f6-95be-95d9216d102d`
      (kernel_verified on the second attempt: `exact pow_mul x m n`). A
      bare `ring` attempt genuinely timed out after 60s (unlike `pow_add`,
      `ring` cannot cheaply normalize a *product* of two variable
      exponents) and is preserved as
      `packets/negative/algebra/pow_mul_ring_timeout_failure.v1.json`.

- [x] `neg_sq` — `(-a) ^ 2 = a ^ 2` (D0, L0). Authored 2026-07-08 by a
      concurrent agent (commit `bd04c9d`) — this file hadn't been synced
      to reflect it until now; fixed to prevent a duplicate re-proof
      attempt.

- [x] `sub_mul` — `(a - b) * c = a * c - b * c` (D0, L0). Authored
      2026-07-08 by a concurrent agent (commit `0427733`) — same sync fix
      as `neg_sq` above.

## Next targets

- [ ] `add_sq_three` — `(a + b + c) ^ 2 = a^2+b^2+c^2+2ab+2bc+2ca` (D1, L1).
      Natural extension of `binomial_sq`; reusable for the geometry/
      inequalities three-variable families that already exist
      (`three_var_am_gm`, `three_var_sq_ge`).
- [ ] `div_add_div_same` — `a / c + b / c = (a + b) / c` for a field (D0,
      L0). No division-identity packet exists yet in this domain.
- [ ] `pow_succ'` — `x ^ (n + 1) = x ^ n * x` (D0, L0). Small but reusable
      in induction proofs (see `packets/elementary/induction/QUEUE.md`).

## Backlog

- [ ] Quadratic formula discriminant nonneg -> real root existence (L1/L2,
      builds on `quad_form_nonneg`).
- [ ] Sum of a finite geometric series, closed form (L1/L2) — pairs with
      `functions/geom_series_mul` (factorization identity) and the induction
      backlog's inductive proof of the same fact; author whichever proof
      style is more natural first, cross-reference the other in
      `CROSS_DOMAIN.md`.
