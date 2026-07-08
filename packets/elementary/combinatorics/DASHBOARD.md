# Dashboard — Combinatorics (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 34 |
| Level breakdown | L0_elementary: 10 · L1_proof_basics: 24 |

- `card_union_add_card_inter.v1.json` (added 2026-07-08) — inclusion-exclusion
  identity `(s ∪ t).card + (s ∩ t).card = s.card + t.card`; kernel-verified
  via episode `23c3ba16-1c40-44bb-ad33-12dd9f01fe60`. Fills the gap flagged
  by the paired negative example
  `packets/negative/combinatorics/finset_card_atoms_omega_failure.v1.json`.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
