# Dashboard — Number Theory (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 1 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

## Packets

- `divisor_case_split_omega_unevaluated_literal.v1` — `omega` fails on a
  divisibility goal whose divisor is a literal-valued but syntactically
  unreduced expression (e.g. `3 + (-1)` left by a case split); `norm_num`
  repairs it. Reproduced live via a tracked proof-search episode
  (dev-attested; `omega` rejected, `norm_num` reached `kernel_verified`).

Last synced: 2026-07-08 — re-sync against `agents/status/MATHCORPUS_STATUS.md`
and `python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
