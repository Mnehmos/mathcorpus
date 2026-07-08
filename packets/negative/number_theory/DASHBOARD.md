# Dashboard — Number Theory (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 3 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

## Packets

- `divisor_case_split_omega_unevaluated_literal.v1` — `omega` fails on a
  divisibility goal whose divisor is a literal-valued but syntactically
  unreduced expression (e.g. `3 + (-1)` left by a case split); `norm_num`
  repairs it. Reproduced live via a tracked proof-search episode
  (dev-attested; `omega` rejected, `norm_num` reached `kernel_verified`).
- `sq_parity_omega_nonlinear_failure.v1` — `omega` fails deterministically
  on `n ^ 2 % 2 = n % 2` because it treats `n ^ 2` as an opaque nonlinear
  atom unrelated to `n`. Captured via tracked proofsearch episode
  `7381250f-097a-4151-b5ba-0e80303ff42e` (problem_version
  `3ea68a09-d6cb-48e6-9b8e-b226d225268a`, dev-attested, `gave_up` after one
  `kernel_fail` solve attempt — no repair step attempted this cycle).
- `gcd_dvd_omega_no_gcd_theory.v1` — `omega` fails on `Nat.gcd a b ∣ a`
  because it has zero theory of `Nat.gcd` (a total gap, not a
  normalization/nonlinearity issue). Tracked via proofsearch episode
  `e92f1fe2-eedb-48d5-94c8-9695aa253fed` (step 1 `omega` -> kernel_fail,
  step 2 `exact Nat.gcd_dvd_left a b` -> kernel_verified — but that
  theorem already existed as `elementary.number_theory.gcd_dvd_left.v1`,
  so no duplicate positive packet was authored).

Last synced: 2026-07-08 — re-sync against `agents/status/MATHCORPUS_STATUS.md`
and `python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
