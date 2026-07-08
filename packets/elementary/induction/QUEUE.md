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
factor, via divisor-search) and `odd_part_decomposition` (every positive
`n` is `2^k * m` for odd `m`, via existential construction on parity —
a distinct strong-induction flavor from `exists_prime_factor`'s).

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

Level-distribution fixes: `one_le_two_pow` (D0, L0, `1 <= 2^n`) and
`factorial_pos_induction` (D0, L0, `0 < n!` — a genuine self-contained
inductive proof, distinct from `number_theory`'s bare-citation
`factorial_pos`), narrowing the domain's original 24:1
`L1_proof_basics`:`L0_elementary` skew to roughly 8:1.

## Done (this cycle)

- [x] `prod_range_pos` — the product of positive terms over a range is
      positive (D1, L1). Authored 2026-07-08 via tracked episode
      `bdbcc4ba-515a-4841-bd7c-e17a73f82152` (kernel_verified on the
      first attempt, deliberately bullet-free to avoid the
      flat-transport hazard). Complements `prod_range_succ`/
      `prod_range_monotone`.

- [x] `factorial_add_ge_mul` — `m! * n! <= (m+n)!` (D1, L1). Authored
      2026-07-08 via tracked episode
      `01e983b5-da63-4abc-8b55-2f6871c98c77` (kernel_verified on the first
      attempt: fix `m`, induct on `n`; `Nat.factorial_succ` rewrites,
      `Nat.mul_le_mul_left` to scale the IH, `nlinarith` to close). This
      domain's first genuinely two-parameter induction — every prior
      packet inducted on a single variable.

- [x] `exists_prime_factorization` — every `n >= 1` is a product of primes,
      existence half of FTA (D2, L1). Authored 2026-07-08 via tracked
      episode `f53c8d62-b8ca-4c32-a697-bf17a76bcb58` (kernel_verified on
      the 4th attempt), strong induction via `n.minFac`. Extends
      `exists_prime_factor` (a single prime factor) to a full
      factorization list. Three real lessons hit and recorded in the
      packet's `notes` field: (1) binding the `1 <= n` hypothesis before
      calling `induction n using Nat.strong_induction_on`, combined with
      `rcases eq_or_lt_of_le hn`, produced a full 60s timeout with zero
      diagnostic — deferring the hypothesis's `intro` to inside the
      induction case, and replacing `eq_or_lt_of_le` with a plain
      `by_cases hn1 : n = 1`, fixed it (unclear which of the two changes
      was the actual cause — both are suspect for future
      `Nat.strong_induction_on` proofs here); (2) `rcases hq with rfl|hq`
      directly on a `List.Mem` hypothesis threw a confusing `subst`
      error blaming a `List ℕ` equality — fix by converting via
      `List.mem_cons.mp hq` to a plain `Or` first; (3) splitting a
      `refine ⟨_, ?_, ?_⟩`'s two goals via flat sequential tactics
      (no bullets) silently left the SECOND goal untouched with no
      tactic error reported at all (category `unsolved_goals`) — always
      wrap each `refine` goal in its own `·` bullet, even when the
      sub-tactics themselves have no nested bullets.

- [x] `sum_consec_product` — tetrahedral-number formula, `3 * sum_{k<n}
      (k+1)*(k+2) = n*(n+1)*(n+2)` (D1, L1). Authored 2026-07-08 via
      tracked episode `1db4baa6-e5da-4a20-956c-614b960aabcc`
      (kernel_verified on the first attempt: `Finset.sum_range_succ` +
      `Nat.mul_add` + `ih` substitution + `ring`). Fills the "finite
      sums" gap one rung above the domain's existing power sums
      (`gauss_sum`/`sum_squares`/`sum_cubes`) and `arith_seq_sum`'s
      general arithmetic series — the sum of the first n triangular
      numbers, stated division-free via the same multiply-through trick
      `arith_seq_sum` uses. Confirmed no prior packet duplicated this
      (`grep -rl triangular\|tetrahedral packets/elementary/*/*.json`,
      no hits) before authoring.

- [x] `two_pow_strictmono` — `n < m` implies `2^n < 2^m` (D1, L1).
      Authored 2026-07-08 via tracked episode
      `9416dbd4-a5a0-452a-a4bb-9eb4d20eda33` (kernel_verified on the
      third attempt, via `strictMono_nat_of_lt_succ` + `pow_succ` +
      `omega`). Fills this domain's weakest-covered focus item,
      monotonicity (previously only `sum_range_monotone`/
      `prod_range_monotone`). Two real lessons: (1) `Nat.pos_pow_of_pos`
      doesn't exist under that name — use the general `pow_pos`;
      (2) after decomposing `m = n + k + 1` via `Nat.exists_eq_add_of_lt`
      and `rw [pow_add]`, the rewrite split off the wrong grouping —
      `n+k+1` parses left-associatively as `(n+k)+1`, so `pow_add`
      produced `2^(n+k) * 2^1`, not the intended `2^n * 2^(k+1)`,
      leaving an unprovable goal shape. Sidestepped entirely by proving
      `StrictMono (fun k => 2^k)` via `strictMono_nat_of_lt_succ`, which
      reduces to a single succ-step with no exponent-splitting ambiguity
      at all — prefer this approach over manual `m = n + k + c`
      decomposition for any future "power/sequence is monotone in its
      index" target.

## Next targets

*(empty — see Backlog.)*

## Backlog

*(empty — repopulate from the domain-specific focus in `LOOP.md`:
induction, strong induction, recursion, finite sums/products, factorials,
powers, inequalities by induction, monotonicity. More genuinely-D0
additions would further narrow the level skew (see `DASHBOARD.md`). v0.1's
numeric release criteria (>=250 public, >=25 negative) were both met this
session — remaining work here is for quality/balance, not raw count. This
domain has multiple concurrent agent instances working it — check
`git log --oneline -15 -- packets/elementary/induction/` before starting
a new target to avoid duplicating recently-landed work.)*
