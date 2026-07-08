# Dashboard — Functions (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 33+ (this domain has multiple concurrent agent instances committing to it every cycle — re-derive the exact count via `python tools/corpus_stats.py` or `git log -- packets/elementary/functions/` rather than trusting this number) |
| Level breakdown | roughly even split between L0_elementary and L1_proof_basics |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/functions/`; this file previously
grew an unbounded per-packet bullet list and has been condensed. The
domain's original 16 packets were all `abs`/`max`/`min` identities
despite its stated focus (injective/surjective/composition/inverse/
monotone/fixed-point/image-preimage basics) — every focus topic now has
multiple packets: `injective_comp`/`surjective_comp`/`id_bijective`,
`linear_injective`, `strictmono_injective`/`strictmono_comp`,
`monotone_comp`, `fixed_point_id`, `image_union`/`preimage_inter`/
`image_inter_subset` (image/preimage family), `min_le_max`, and now
`inverse`'s full pair: `left_inverse_injective` (a left inverse implies
injectivity) and this cycle's `right_inverse_surjective` (D0, L1, episode
`6f12df1e`: a right inverse implies surjectivity — the witness `g b`
satisfies `f (g b) = b` directly from the definition, no rewriting
needed). A prior cycle's dashboard claimed "every focus topic" was
covered before `inverse` actually had any packets — re-verify claims
like that against a grep of the actual files, not just the prose here.
And this cycle's `bijective_comp` (D0, L1, episode `0b5fbe31`): the
composition of two bijective functions is bijective, completing the
`injective_comp`/`surjective_comp` pair with the combined `Bijective`
statement.

Next targets: see `QUEUE.md`.
