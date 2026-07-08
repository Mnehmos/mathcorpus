# Queue — Combinatorics (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 33 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `card_filter_add_card_filter_not` — `(s.filter p).card + (s.filter
      (fun a => ¬ p a)).card = s.card` (D1, L1). Verified this exact
      declaration exists in Mathlib. The domain has `filter_subset'` but
      no counting/partition identity for filters yet.

## Backlog

- [ ] (empty)
