# Queue — Induction (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
**This domain is the smallest in the corpus (8 packets) — prioritize it
over other elementary domains when otherwise unconstrained**, per
`agents/status/MATHCORPUS_STATUS.md`.

## Done

- [x] `two_pow_gt_self` — `n < 2 ^ n` for all `n` (D0, L0). Authored
      2026-07-08 via tracked episode `5a175c43-1c93-4cf7-a4e9-5038e1961068`
      (kernel_verified: `induction n with | zero => norm_num | succ n ih =>
      rw [pow_succ]; nlinarith [ih]`). The naive `nlinarith [ih]` attempt
      (no `pow_succ` rewrite) kernel-failed first in the same episode and is
      preserved as
      `packets/negative/induction/pow_succ_atom_nlinarith_failure.v1.json`.
- [x] `bernoulli_inequality` — `1 + n*x <= (1+x)^n` for `x >= -1` (D1, L1).
      Authored 2026-07-08 via tracked episode
      `344364cb-791a-4e8a-9f5e-be0cc95210de` (kernel_verified on the first
      attempt: `induction n`, `mul_le_mul_of_nonneg_right ih hx'` +
      `sq_nonneg x` as nlinarith hints). Uses `InequalityEstimateKit`
      (recorded in `CROSS_DOMAIN.md`); cross-references
      `packets/elementary/inequalities/`.
- [x] `sum_evens` — `∑ i ∈ range n, (2*i+2) = n*(n+1)` (2, 4, ..., 2n) (D1,
      L1). Authored 2026-07-08 via tracked episode
      `7c564d42-9a98-4780-9d1c-3affd65958d6` (kernel_verified on the first
      attempt: `induction n with | zero => simp | succ k ih => rw
      [Finset.sum_range_succ, ih]; ring`). Reformulated from the queue's
      `2*i = n*(n-1)` phrasing to the subtraction-free `2*(i+1) = n*(n+1)`
      form (first n positive evens 2..2n) to avoid ℕ truncated-subtraction
      noise in the successor step — mirrors `sum_odds`'s style. Needed an
      explicit `problem_imports:
      ["Mathlib.Algebra.BigOperators.Group.Finset.Basic"]` on
      `problem_create`; the base dev-attestation manifest (Ring + NormNum
      only) does not carry `Finset.sum`/`∑` notation, and `open scoped
      BigOperators` no longer resolves under this pinned Mathlib rev
      (namespace doesn't exist) — don't reuse that directive for future
      Finset.sum targets in this domain.

- [x] `factorial_ge_two_pow` — `2 ^ n <= (n + 1)!` for all `n` (D1, L1),
      equivalent via `n -> n - 1` to the queue's original `n! >= 2^(n-1)`
      for `n >= 1` phrasing, restated shifted-by-one to avoid ℕ truncated
      subtraction. Authored 2026-07-08 via tracked episode
      `538ea8b6-6ad7-4a16-9e9b-bda5364ba942` (kernel_verified on the first
      attempt: `induction n with | zero => norm_num [Nat.factorial] | succ
      n ih => rw [Nat.factorial_succ, pow_succ]; nlinarith [ih,
      Nat.factorial_pos (n + 1)]`). Cross-referenced against
      `packets/elementary/number_theory/factorial_pos.v1.json` /
      `factorial_le.v1.json` in `CROSS_DOMAIN.md` (no direct proof-term
      dependency, same subject matter).

- [x] `geom_series_sum_induction` — `(∑ i ∈ range n, r ^ i) * (r - 1) = r ^
      n - 1` over `ℤ` (D1, L1). Authored 2026-07-08 via tracked episode
      `f99a1298-917b-4e15-9fc4-edcce273d204` (kernel_verified on the first
      attempt: `induction n with | zero => simp | succ k ih => rw
      [Finset.sum_range_succ, add_mul, ih]; ring`). This entry had gone
      stale — the packet already existed on disk (landed in commit
      `acb84ec` after a concurrent-write race dropped it from `ca0f1d6`)
      but this queue file hadn't been updated to reflect it; fixed here to
      prevent a duplicate re-proof attempt by a concurrent domain-agent
      instance.

## Next targets

*(empty — see Backlog; this domain has multiple concurrent agent
instances working it, so check `git log -- packets/elementary/induction/`
for very recent commits before re-populating.)*

## Backlog

- [ ] Strong induction example: every `n >= 2` has a prime factor (L1/L2 —
      ties to the number_theory domain's planned `prime_two` /
      `not_prime_one` packets; author those first).
