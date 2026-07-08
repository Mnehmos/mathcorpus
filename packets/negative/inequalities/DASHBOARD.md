# Dashboard — Inequalities (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 1 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

Packets:

- `three_var_sq_bare_nlinarith_failure.v1.json` — bare `nlinarith` (no
  `sq_nonneg` hints) fails on `a^2+b^2+c^2 >= ab+bc+ca`; captured from a real
  tracked episode (`d1e875d2-1cef-45c1-a76e-d46e84f67aa9`) whose first step
  recorded `kernel_fail` before a hinted retry closed it `kernel_verified`.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
