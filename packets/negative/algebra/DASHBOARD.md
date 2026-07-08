# Dashboard — Algebra (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 5 |
| Level breakdown | L0_elementary: 3, L1_proof_basics: 2 — see `trust.rung: 0` |

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
- `frac_sum_bare_ring_missing_field_simp.v1.json` — bare `ring` (no
  `field_simp`) fails on `1/a + 1/b = (a+b)/(a*b)` for nonzero a, b
  (`unsolved_goals`, un-cancelled `a * a⁻¹`/`b * b⁻¹` residual); `ring`
  has no mechanism to use the nonzero hypotheses. Tracked via proofsearch
  episode `580850dc-88c1-464d-8b21-d4d02a1f3631` (step 1 bare `ring` ->
  kernel_fail, step 2 `field_simp; ring` -> kernel_verified, authored as
  the companion positive packet
  `elementary.algebra.sum_reciprocals_eq_sum_over_product.v1`). Resolves
  the domain's queued "ring on a division identity without field_simp"
  candidate.
- `div_mul_cancel_bare_ring_no_hypothesis_failure.v1.json` — bare `ring`
  fails on `a / b * b = a` for nonzero `b`, reducing to the un-cancelled
  residual `a * b * b⁻¹ = a`; `field_simp` closes it. Tracked via
  proofsearch episode `e292756d-c2f5-4bf4-a211-8b827e3751d4` (step 1 bare
  `ring` -> kernel_fail, step 2 `field_simp` -> kernel_verified). A second,
  independently-landed instance of the same ring-ignores-hypotheses lesson
  as `frac_sum_bare_ring_missing_field_simp.v1.json` above, on a distinct
  concrete statement.
- `pow_mul_ring_timeout_failure.v1.json` — bare `ring` genuinely times out
  after 60s on `x^(m*n) = (x^m)^n` (unlike the sibling `pow_add`, where
  `ring` closes `x^(m+n) = x^m*x^n` instantly); `exact pow_mul x m n`
  closes the same tracked episode (`13c20f38-d366-44f6-95be-95d9216d102d`)
  `kernel_verified`. A distinct sub_category (timeout, not a clean
  rejection) from this lane's other `ring` examples.

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
