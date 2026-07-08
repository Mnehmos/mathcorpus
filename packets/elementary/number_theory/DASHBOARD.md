# Dashboard — Number Theory (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 52+ |
| Level breakdown | L0_elementary: 24 · L1_proof_basics: 26+ · L2_olympiad: 1 |

Last synced: 2026-07-08 — added `prime_two` (D0, L0, episode
`86b4db53-554e-4887-a579-adfc290a0cb5`): `Nat.Prime 2` via `norm_num`,
the domain's first primality fact. Also present: `well_ordering` (D1, L1,
episode `96e95cc1-bdbf-41b7-b71d-cadd6ed1109a`): every nonempty `Set ℕ`
has a least element, via `Nat.strong_induction_on`; `lcm_comm` (another
concurrent agent). Also added `even_sq` (D1, L1, episode
`5bbacd66-df54-4a0f-9dd7-d2aa08b946ba`): `Even (n^2) <-> Even n` via
`Nat.even_pow'`, the classic fact from the standard irrationality-of-
sqrt-2 proof pattern. Re-sync against `agents/status/MATHCORPUS_STATUS.md`
and `python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
