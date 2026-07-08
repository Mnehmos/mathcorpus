# Dashboard — Algebra (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 1 |
| Level breakdown | L0_elementary: 1 — see `trust.rung: 0` |

Packets:

- `nat_sub_ring_trap.v1.json` — `ring` fails on a `ℕ` truncated-subtraction
  cancellation (`a - b + b = a` given `b ≤ a`) because `ring` treats
  `Nat.sub` as an opaque atom and ignores the hypothesis; `omega` closes it.
  Tracked via proofsearch episode `b2f5f359-6f9c-42dd-b749-ee70b931ff70`
  (step 1 `ring` -> kernel_fail, step 2 `omega` -> kernel_verified).

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
