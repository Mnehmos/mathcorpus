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

- [x] `foldl_cons_eq_reverse_append` — `l.foldl (fun a x => x :: a) acc =
      l.reverse ++ acc` for `l acc : List ℕ` (D1, L1). Authored 2026-07-08
      via tracked episode `0ab12a3b-a0fb-4981-b6fe-63628a4f6fb6`
      (kernel_verified: `intro l acc; induction l with | nil => simp |
      cons x xs ih => simp [ih]`). Originally attempted as the negative
      example queued in `packets/negative/induction/QUEUE.md` for
      "induction without generalizing an auxiliary variable" — `simp [ih]`
      turned out strong enough to close it despite `acc` not being
      generalized, so the hypothesis was false and this became a positive
      packet instead (queue corrected to suggest a weaker closing tactic
      for a real attempt at that failure mode).

## Done (continued)

- [x] Strong induction example: every `n >= 2` has a prime factor. Authored
      2026-07-08 as `exists_prime_factor` via tracked episode
      `ac1ea7d4-4b1a-406e-8c2a-e209d5cd03d5` (kernel_verified on the first
      attempt: `Nat.strong_induction_on`, case split on `n.Prime`,
      `Nat.exists_dvd_of_not_prime2` for the non-prime branch, `dvd_trans`
      to close). Proved directly against Mathlib's primality API rather
      than waiting on the number_theory domain's `prime_two` /
      `not_prime_one` packets — those were a suggested narrative ordering,
      not a real Lean dependency (`Nat.Prime` and its lemmas already exist
      in Mathlib regardless of whether those trivial packets are
      authored). This is the domain's first packet using genuine strong
      induction (`Nat.strong_induction_on`) rather than plain
      `induction n with zero | succ`.

- [x] Recursion via `SubmitModule`: hand-rolled `myFactorial` (helper `def`
      via `Nat.rec`) proved equal to `Nat.factorial`. Authored 2026-07-08
      as `myfactorial_eq_factorial` via tracked episode
      `99b8de59-4ed4-4fa8-b0cd-0d966b9ba800` (kernel_verified on the first
      attempt, submitted as a `SubmitModule` action — one helper `def` +
      root theorem — rather than a single `Solve` tactic block; confirmed
      `problem_create` hash-matches the root statement syntactically, so a
      root statement may reference a helper name that doesn't exist yet at
      registration time). This domain's first packet exercising
      `SubmitModule` — every prior packet used `Solve` only.

- [x] Mutual recursion via `mutual_group`: `even_odd_mutual_totality`
      already landed (commit `824410b`) — a concurrent domain-agent
      instance beat this note to it; removed from backlog to avoid a
      duplicate attempt.
- [x] "Induction without generalizing an auxiliary variable" negative
      example attempt pivoted to a positive packet,
      `foldl_cons_eq_reverse_append` (commit `5c61d06`) — `simp [ih]`
      turned out strong enough despite `acc` not being generalized, so the
      intended failure never materialized.

- [x] Fibonacci-style growth bound: hand-rolled `fib` via pair-encoding
      recursion (`fibPair n = (fib n, fib (n+1))`, `Nat.rec` on pairs)
      satisfies `fib n <= 2^n`. Authored 2026-07-08 as `fib_le_two_pow` via
      tracked episode `11c5774d-6e4a-41f5-9a68-d8041146d59d`
      (kernel_verified on the **second** `SubmitModule` attempt; the first
      used `show` to jump to a `Prod.fst`/`Prod.snd`-reduced goal before
      `omega`, which left `omega` looking at the un-reduced
      `(fibPair (n+1)).2` atom and failed — fixed by adding an explicit
      `fibPair_succ : fibPair (n+1) = (..) := rfl` lemma and using it as a
      `simp` rewrite instead of `show`). Tactic-transport lesson: prefer an
      explicit `rfl` unfolding lemma + `simp`/`rw` over `show` when a proof
      needs a pair/tuple projection reduced before arithmetic automation
      runs — `show`'s defeq check can silently accept a goal-swap without
      actually normalizing the term `omega`/`nlinarith` will see.

- [x] `prod_range_monotone` — partial products of a `>=1`-valued sequence
      are monotone in the upper bound (mirrors `sum_range_monotone`, which
      only needs `>=0`, automatic in ℕ). Authored 2026-07-08 via tracked
      episode `5918401a-b5cd-492f-96f9-1bcbf785885e` (kernel_verified on
      the first attempt: `induction k`, `Finset.prod_range_succ`,
      `le_mul_of_one_le_right`). Sibling of `sum_range_monotone.v1`, not a
      cross-domain dependency, so not recorded in `CROSS_DOMAIN.md`.

## Backlog

*(empty — repopulate from the domain-specific focus in `LOOP.md`:
induction, strong induction, recursion, finite sums/products, factorials,
powers, inequalities by induction, monotonicity. This domain has multiple
concurrent agent instances working it — check
`git log --oneline -15 -- packets/elementary/induction/` before starting
a new target to avoid duplicating recently-landed work.)*
