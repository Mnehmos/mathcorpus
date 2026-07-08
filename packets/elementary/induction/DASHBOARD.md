# Dashboard — Induction (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 29+ (this domain has multiple concurrent agent instances committing to it every cycle — re-derive the exact count via `python tools/corpus_stats.py` or `git log -- packets/elementary/induction/` rather than trusting this number) |
| Level breakdown | L0_elementary: 3 (`two_pow_gt_self`, `one_le_two_pow`, `factorial_pos_induction`) · rest `L1_proof_basics` |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/induction/`; this file previously
grew an unbounded per-packet bullet list and has been condensed to avoid
that recurring elsewhere (re-condensed again this cycle). Highlights:
every recursion technique in `LOOP.md`'s focus list is demonstrated
(structural `myfactorial_eq_factorial`, mutual `even_odd_mutual_totality`,
well-founded `mygcd_wellfounded`/`euclid_gcd_eq_gcd`); both strong-induction
flavors are demonstrated (`exists_prime_factor` divisor-search,
`odd_part_decomposition` existential construction); general reusable
lemmas (`telescoping_sum`, `arith_seq_sum`) sit alongside the domain's
many specific closed-form sums; `two_pow_gt_sq_from_five` demonstrates
shifted-threshold induction (`Nat.le_induction`) with a paired negative
example at the boundary. This domain was heavily skewed toward
`L1_proof_basics` (24:1 before this cycle) — `one_le_two_pow` (D0, L0,
episode `5a603590-f54f-4eca-8fbe-d5340aa69929`: `1 <= 2^n`) and this
cycle's `factorial_pos_induction` (D0, L0, episode
`d6963e91-cc3b-4c20-85ca-de8257294ba2`: `0 < n!`, a genuine inductive
proof distinct from `number_theory`'s bare-citation `factorial_pos`)
continue offsetting that. Also added `prod_range_pos` (D1, L1, episode
`bdbcc4ba-515a-4841-bd7c-e17a73f82152`): the product of positive terms
over a range is positive, a general reusable lemma complementing
`prod_range_succ`/`prod_range_monotone`; deliberately bullet-free in its
tactic script to avoid the flat-transport hazard. And
`factorial_add_ge_mul` (D1, L1, episode
`01e983b5-da63-4abc-8b55-2f6871c98c77`): `m! * n! <= (m+n)!`, this
domain's first genuinely two-parameter induction (m held fixed, induct on
n) — every prior packet inducted on a single variable. This cycle's
`exists_prime_factorization` (D2, L1, episode `f53c8d62`): every n>=1 is
a product of primes (existence half of FTA), strong induction via
`Nat.minFac` — extends `exists_prime_factor`'s single-factor existence to
a full factorization list. And `sum_consec_product` (D1, L1, episode
`1db4baa6`): the tetrahedral-number formula (sum of the first n
triangular numbers), stated division-free as `3 * sum (k+1)*(k+2) =
n*(n+1)*(n+2)` — the next rung above `gauss_sum`/`sum_squares`/
`sum_cubes`'s power sums and `arith_seq_sum`'s general arithmetic series.
This cycle's `two_pow_strictmono` (D1, L1, episode `9416dbd4`): `n < m`
implies `2^n < 2^m`, filling this domain's weakest-covered focus item
(monotonicity — previously only `sum_range_monotone`/`prod_range_monotone`
existed) via `strictMono_nat_of_lt_succ`.

Next targets: see `QUEUE.md`.
