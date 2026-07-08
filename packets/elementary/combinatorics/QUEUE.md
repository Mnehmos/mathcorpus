# Queue — Combinatorics (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 33 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `card_sdiff_of_subset` — `t <= s -> (s \ t).card = s.card - t.card`
      (D1, L1). The domain has union/intersection cardinality identities
      but nothing for set difference; verified `Finset.card_sdiff_of_subset`
      exists in Mathlib.
- [ ] A general (non-concrete) pigeonhole statement, e.g.
      `t.card < s.card -> exists f-collision` for arbitrary `s t : Finset
      ℕ` and `f : ℕ -> ℕ` with `MapsTo` — generalizes the existing concrete
      `pigeonhole_3_into_2` instance.

## Backlog

- [ ] (empty)
