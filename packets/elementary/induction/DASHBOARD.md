# Dashboard — Induction (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 23+ (this domain has multiple concurrent agent instances committing to it every cycle — re-derive the exact count via `python tools/corpus_stats.py` or `git log -- packets/elementary/induction/` rather than trusting this number) |
| Level breakdown | mostly L1_proof_basics, one L0 (`two_pow_gt_self`) |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/induction/`; this file previously
grew an unbounded per-packet bullet list and has been condensed to avoid
that recurring elsewhere. Highlights: every recursion technique in this
domain's `LOOP.md` focus list is now demonstrated — structural
(`myfactorial_eq_factorial`), mutual (`even_odd_mutual_totality`), and
well-founded/non-structural (`mygcd_wellfounded`, `euclid_gcd_eq_gcd`,
which strengthens the well-founded case to a full correctness proof
against `Nat.gcd` rather than a base-case-only fact). Also added
`arith_seq_sum` (D1, L1, episode `b6ef7a97-8dc3-4d6c-b031-d31806c8cb53`):
the general arithmetic-series formula, generalizing `gauss_sum`/
`sum_odds`/`sum_evens` into one reusable lemma.

Next targets: see `QUEUE.md`.
