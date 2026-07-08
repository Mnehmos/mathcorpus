# Queue — Combinatorics (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 33 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `card_powerset` — `(Finset.powerset s).card = 2 ^ s.card` (D1, L1).
      A headline finite-combinatorics fact; currently nothing in this
      domain touches `powerset` at all.
- [ ] `choose_zero_right` / `choose_self` / `choose_symm` — basic binomial
      coefficient identities (D0/D1, L0/L1). The roadmap's "finite
      combinatorics basics" starter family names this explicitly; no
      `Nat.choose` packet exists yet in the corpus at all.
- [ ] A concrete pigeonhole instance (e.g. 3 items into 2 boxes forces a
      repeated box) (D1, L1). The domain's own `README.md` focus text
      names "pigeonhole-style basics" explicitly, but zero packets cover
      it — this is the single largest focus/content gap in the domain.

## Backlog

- [ ] `card_image_le` — `(s.image f).card <= s.card` (L1).
- [ ] Sum of first `n` binomial coefficients `= 2 ^ n` (L1/L2, ties to the
      induction domain's backlog and to `ExtremalCombinatoricsKit`).
