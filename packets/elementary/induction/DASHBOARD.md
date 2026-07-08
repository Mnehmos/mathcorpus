# Dashboard — Induction (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 26+ (this domain has multiple concurrent agent instances committing to it every cycle — re-derive the exact count via `python tools/corpus_stats.py` or `git log -- packets/elementary/induction/` rather than trusting this number) |
| Level breakdown | L0_elementary: 2 (`two_pow_gt_self`, `one_le_two_pow`) · rest `L1_proof_basics` |

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
episode `5a603590-f54f-4eca-8fbe-d5340aa69929`: `1 <= 2^n`) is the second
`L0_elementary` packet, deliberately picked to start offsetting that.

Next targets: see `QUEUE.md`.
