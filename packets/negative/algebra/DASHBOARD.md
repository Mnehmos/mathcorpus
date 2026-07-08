# Dashboard — Algebra (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 2 |
| Level breakdown | L0_elementary: 1, L1_proof_basics: 1 — see `trust.rung: 0` |

Packets:

- `nat_sub_ring_trap.v1.json` — `ring` fails on a `ℕ` truncated-subtraction
  cancellation (`a - b + b = a` given `b ≤ a`) because `ring` treats
  `Nat.sub` as an opaque atom and ignores the hypothesis; `omega` closes it.
  Tracked via proofsearch episode `b2f5f359-6f9c-42dd-b749-ee70b931ff70`
  (step 1 `ring` -> kernel_fail, step 2 `omega` -> kernel_verified).
- `sq_sum_bare_nlinarith_missing_sos_hint.v1.json` — bare `nlinarith` (no
  hints) fails on `a^2 + b^2 >= 2*a*b` over ℝ (`linarith failed to find a
  contradiction`); `nlinarith [sq_nonneg (a - b)]` closes it. Tracked via
  proofsearch episode `42da9f6e-6693-4354-8b0b-9332b7d91def` (step 1 bare
  `nlinarith` -> kernel_fail, step 2 with the SOS hint -> kernel_verified,
  authored as the companion positive packet
  `elementary.algebra.sq_sum_ge_two_mul.v1`).

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
