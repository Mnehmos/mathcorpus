# Queue — Algebra (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 41 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `pow_add` — `x ^ (m + n) = x ^ m * x ^ n` (D0, L0). Reusable exponent
      law, currently missing despite `pow_two`/`pow_one'`/`pow_zero'`
      already present.
- [ ] `pow_mul` — `x ^ (m * n) = (x ^ m) ^ n` (D0, L0). Pairs with
      `pow_add`.
- [ ] `neg_sq` — `(-a) ^ 2 = a ^ 2` (D0, L0). Natural companion to
      `mul_neg'`/`neg_neg'`/`pow_two`, currently missing as its own named
      packet.
- [ ] `sub_mul` — `(a - b) * c = a * c - b * c` (D0, L0). `mul_add'` and
      `add_mul'` exist; the subtraction variant doesn't.
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
