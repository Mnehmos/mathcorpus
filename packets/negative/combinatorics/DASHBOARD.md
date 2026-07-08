# Dashboard — Combinatorics (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 1 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

- `finset_card_atoms_omega_failure.v1.json` — `omega` applied directly to raw
  `Finset.card` atoms (union/intersection identity) without bridging through
  `Finset.card_union_add_card_inter` first; produced via a real tracked
  episode (`29b897d0-2c51-4a9b-8bb4-5f781b0a753c`) that reached `gave_up`
  after a genuine `omega` kernel_fail.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
