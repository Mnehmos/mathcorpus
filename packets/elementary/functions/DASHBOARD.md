# Dashboard — Functions (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 30+ (this domain has multiple concurrent agent instances committing to it every cycle — re-derive the exact count via `python tools/corpus_stats.py` or `git log -- packets/elementary/functions/` rather than trusting this number) |
| Level breakdown | roughly even split between L0_elementary and L1_proof_basics |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/functions/`; this file previously
grew an unbounded per-packet bullet list and has been condensed. The
domain's original 16 packets were all `abs`/`max`/`min` identities
despite its stated focus (injective/surjective/composition/inverse/
monotone/fixed-point/image-preimage basics) — every focus topic now has
multiple packets: `injective_comp`/`surjective_comp`/`id_bijective`,
`linear_injective`, `strictmono_injective`/`strictmono_comp`,
`monotone_comp`, `fixed_point_id`, `image_union`/`preimage_inter`/this
cycle's `image_inter_subset` (image/preimage family), and `min_le_max`.

Next targets: see `QUEUE.md`.
