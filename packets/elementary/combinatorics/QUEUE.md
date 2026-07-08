# Queue — Combinatorics (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 33 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `choose_succ_succ` (Pascal's rule) — `Nat.choose (n+1) (k+1) =
      Nat.choose n k + Nat.choose n (k+1)` (D1, L1). Natural next
      `Nat.choose` identity now that the basics are in place; ties directly
      to the backlog's binomial-sum item below.

## Backlog

- [ ] Sum of first `n` binomial coefficients `= 2 ^ n` (L1/L2, ties to the
      induction domain's backlog and to `ExtremalCombinatoricsKit`).
