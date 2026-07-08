# Queue — Combinatorics (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 33 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `card_powerset` — `(Finset.powerset s).card = 2 ^ s.card` (D1, L1).
      A headline finite-combinatorics fact; currently nothing in this
      domain touches `powerset` at all.
- [ ] `card_union_add_card_inter` — `(s ∪ t).card + (s ∩ t).card = s.card +
      t.card` (D1, L1). The domain only has `card_union_le'` (an
      inequality); the exact inclusion-exclusion identity is missing.
- [ ] `disjoint_left` / a concrete disjoint-union card equality — `Disjoint
      s t -> (s ∪ t).card = s.card + t.card` (D0, L0/L1). No `Disjoint`
      packet exists yet, and it's the natural equality companion to the
      existing `card_union_le'` inequality — pairing them also sets up the
      negative-example candidate in `packets/negative/combinatorics/QUEUE.md`.
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
