# Dashboard — Combinatorics (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 35 |
| Level breakdown | L0_elementary: 10 · L1_proof_basics: 25 |

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

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
