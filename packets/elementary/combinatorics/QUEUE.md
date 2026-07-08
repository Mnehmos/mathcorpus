# Queue — Combinatorics (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 33 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `choose_self` — `Nat.choose n n = 1` (D0, L0). Companion to the now-
      committed `choose_zero_right`.
- [ ] `choose_symm` — `Nat.choose n k = Nat.choose n (n - k)` for `k <= n`
      (D1, L1). The roadmap's "finite combinatorics basics" starter family
      names this explicitly.

## Backlog

- [ ] `card_image_le` — `(s.image f).card <= s.card` (L1).
- [ ] Sum of first `n` binomial coefficients `= 2 ^ n` (L1/L2, ties to the
      induction domain's backlog and to `ExtremalCombinatoricsKit`).
