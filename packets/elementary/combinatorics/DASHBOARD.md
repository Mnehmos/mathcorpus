# Dashboard — Combinatorics (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 39 |
| Level breakdown | see individual packets — includes `card_union_not_additive.v1.json` (another concurrent agent's addition, commit `246ca69`) not itemized below |

- `card_union_add_card_inter.v1.json` (added 2026-07-08) — inclusion-exclusion
  identity `(s ∪ t).card + (s ∩ t).card = s.card + t.card`; kernel-verified
  via episode `23c3ba16-1c40-44bb-ad33-12dd9f01fe60`. Fills the gap flagged
  by the paired negative example
  `packets/negative/combinatorics/finset_card_atoms_omega_failure.v1.json`.
- `disjoint_union_card.v1.json` (added 2026-07-08) — equality companion to
  `card_union_le'`: `Disjoint s t → (s ∪ t).card = s.card + t.card`; kernel-
  verified via episode `c0c34f8f-f08d-4b4c-a698-29d26328546b`. Sets up the
  "false without disjointness" negative-example candidate still queued in
  `packets/negative/combinatorics/QUEUE.md`.
- `pigeonhole_3_into_2.v1.json` (added 2026-07-08) — the domain's first
  pigeonhole-principle packet (`README.md`'s largest documented focus
  gap): 3 items into 2 boxes forces a repeated box, via
  `Finset.exists_ne_map_eq_of_card_lt_of_maps_to`; kernel-verified via
  episode `f2716b47-cc6b-4e6c-b791-1e153a4edf22`.
- `card_powerset.v1.json` (added 2026-07-08) — the headline finite-
  combinatorics fact `(Finset.powerset s).card = 2 ^ s.card`, the domain's
  first packet to touch `powerset`; kernel-verified via episode
  `53929392-6942-40dd-a25f-69379262bf28`.
- `choose_zero_right.v1.json` (added 2026-07-08) — `Nat.choose n 0 = 1`,
  the domain's first `Nat.choose` packet, opening the roadmap's "finite
  combinatorics basics" binomial-coefficient family; kernel-verified via
  episode `dbba5471-27a3-4f88-938f-8006ecdc8a5c`. `choose_self` and
  `choose_symm` remain queued as follow-ups.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
