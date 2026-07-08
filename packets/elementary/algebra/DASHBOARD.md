# Dashboard — Algebra (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 44+ (multiple concurrent agent instances committing every cycle — re-derive via `python tools/corpus_stats.py`) |
| Level breakdown | mostly L0_elementary, some L1_proof_basics/L2_olympiad |

Last synced: 2026-07-08 — added `pow_add` (D0, L0, episode
`fa0521fa-5205-4059-9071-c5519c5f3392`): `x^(m+n) = x^m * x^n` via `ring`,
a reusable exponent law previously missing from the domain despite
`pow_two`/`pow_one'`/`pow_zero'` already present. Re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
