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
`prime_dvd_mul`). Also added `gcd_mul_lcm` (D1, L1, episode
`f6352ddf-5a46-4adf-ac9a-4036cb887f47`): `Nat.gcd a b * Nat.lcm a b = a *
b`, the classic identity tying the `gcd_*` and `lcm_*` families together.
Re-sync against `agents/status/MATHCORPUS_STATUS.md` and
`python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
