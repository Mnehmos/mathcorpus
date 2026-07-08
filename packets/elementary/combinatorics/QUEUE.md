# Queue — Combinatorics (Elementary)

Candidate packets to create or formalize next, roughly in priority order.

## Done (this cycle)

- [x] `set_mem_union` — `a ∈ s ∪ t ↔ a ∈ s ∨ a ∈ t` for `Set` (D0, L0).
      Authored 2026-07-08 via tracked episode
      `d5cb1cff-dba3-418a-8e99-ffecba1d3000` (kernel_verified on the first
      attempt: `exact Set.mem_union a s t`). The domain's first plain-`Set`
      (non-`Finset`) packet, closing the gap the README focus text
      ("Finset, Set") had flagged but no prior packet covered.

- [x] `card_product` — `(s ×ˢ t).card = s.card * t.card`, the
      fundamental counting principle for Cartesian products (D1, L1).
      Authored 2026-07-08 via tracked episode
      `04430956-5741-493c-bd5c-fcb31cb89d30` (kernel_verified on the
      first attempt: `exact Finset.card_product s t`). First packet in
      the domain to cover Finset products (`s ×ˢ t`) — the README names
      "products" among its focus areas alongside sums, but no prior
      packet used it at all.

## Next targets

*(empty)*

## Backlog

- [ ] (empty — repopulate from the domain's README focus: Finset, Set,
      membership, union, intersection, filters, cardinality, products,
      sums, pigeonhole-style basics. Most sub-areas now have at least one
      packet; check `git log --oneline -20 -- packets/elementary/combinatorics/`
      before starting a new target, since concurrent agents work this
      domain too.)
