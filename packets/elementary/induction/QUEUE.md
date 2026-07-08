# Queue — Induction (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
**This domain has repeatedly been the smallest in the corpus** — prioritize
it over other elementary domains when otherwise unconstrained, per
`agents/status/MATHCORPUS_STATUS.md` — though check current per-domain
counts before assuming that's still true, since multiple concurrent agent
instances work this domain every cycle.

Per-packet history (episode IDs, tactic scripts, lessons learned) lives in
each packet's own `verification.episode_id`/`notes` fields and in
`git log -- packets/elementary/induction/`; this file previously grew an
unbounded, repeatedly-headered "Done" list and has been condensed here
(same cleanup already applied to this domain's `DASHBOARD.md` and to the
inequalities/combinatorics domains this session).

## Done (condensed)

Closed-form finite sums/products (`Finset.sum_range_succ` /
`Finset.prod_range_succ` + `ring`/`omega`): `gauss_sum`, `sum_odds`,
`sum_evens`, `sum_squares`, `sum_cubes`, `sum_range_succ`,
`prod_range_succ`, `geom_series_sum_induction`, `fib_sum_succ`.

General reusable lemmas (distinct from the specific closed forms above):
`telescoping_sum` (the general telescoping principle), `arith_seq_sum`
(the general arithmetic-series formula, generalizing `gauss_sum`/
`sum_odds`/`sum_evens`).

Monotonicity: `sum_range_monotone`, `prod_range_monotone` (its product
sibling).

Inequalities by induction / powers: `two_pow_gt_self`, `bernoulli_inequality`,
`factorial_ge_two_pow`, `fib_le_two_pow` (growth bound on a hand-rolled
pair-encoded Fibonacci).

Strong induction: `exists_prime_factor` (every `n >= 2` has a prime
factor).

Recursion via `SubmitModule` (every technique in `LOOP.md`'s focus list is
now demonstrated): structural (`myfactorial_eq_factorial`), mutual
(`even_odd_mutual_totality`), well-founded/non-structural
(`mygcd_wellfounded`, `euclid_gcd_eq_gcd` — the latter strengthens the
former's base-case-only result to full correctness against `Nat.gcd`; see
that packet's `notes` for the `WellFoundedLT.fix`/`Nat.strongRecOn`
unfolding lesson, since neither reduces by `rfl`).

Lists: `foldl_cons_eq_reverse_append` (originally attempted as a negative
example for "induction without generalizing an auxiliary variable" —
`simp [ih]` turned out strong enough despite `acc` not being generalized,
so it became a positive packet instead; see
`packets/negative/induction/` for a version of that failure mode that
*did* reproduce).

Shifted-threshold induction: `two_pow_gt_sq_from_five` (`2^n > n^2` only
from `n = 5` onward, via `Nat.le_induction`; paired negative example
`two_pow_gt_sq_offbyone_naive_ih_failure` shows plain `induction n with
zero | succ` gives a vacuous, unusable inductive hypothesis at the `n = 4`
boundary — resolves `packets/negative/induction/QUEUE.md`'s "off-by-one
base case error" backlog item).

## Next targets

- [x] `odd_part_decomposition` — every positive `n` is `2^k * m` for odd
      `m` (D1, L1). Authored 2026-07-08 via tracked episode
      `ce2bb257-0a1a-4596-a401-f9da247175d8` (kernel_verified on the first
      attempt: `Nat.strong_induction_on`, `Nat.even_or_odd` case split,
      recurse on the halved value). Second genuine strong-induction
      packet in this domain — an existential construction, distinct in
      flavor from `exists_prime_factor`'s divisor-search.

## Backlog

*(empty — repopulate from the domain-specific focus in `LOOP.md`:
induction, strong induction, recursion, finite sums/products, factorials,
powers, inequalities by induction, monotonicity. Note: v0.1's numeric
release criteria (>=250 public, >=25 negative) were both met this
session — remaining work here is for quality/balance (level-distribution
gaps, fresh techniques), not raw count. This domain has multiple
concurrent agent instances working it — check
`git log --oneline -15 -- packets/elementary/induction/` before starting
a new target to avoid duplicating recently-landed work.)*
