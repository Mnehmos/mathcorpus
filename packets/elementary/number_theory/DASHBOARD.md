# Dashboard — Number Theory (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 56+ (multiple concurrent agent instances committing every cycle — re-derive via `python tools/corpus_stats.py`) |
| Level breakdown | L0_elementary: 25+ · L1_proof_basics: 26+ · L2_olympiad: 1 |

Last synced: 2026-07-08 — added `not_prime_one` (D0, L0, episode
`ec66cf9d-8d79-4e2c-9178-e016e854a709`): `¬ Nat.Prime 1` via `norm_num`,
pairing with `prime_two`. Also present (this session, various agents):
`prime_two`, `prime_dvd_mul`, `lcm_comm`, `even_sq`, `well_ordering`. This
domain now has a small primality family (`prime_two`, `not_prime_one`,
`prime_dvd_mul`). Re-sync against `agents/status/MATHCORPUS_STATUS.md`
and `python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
