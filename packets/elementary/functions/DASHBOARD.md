# Dashboard — Functions (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 24+ (this domain has multiple concurrent agent instances committing to it every cycle — re-derive the exact count via `python tools/corpus_stats.py` or `git log -- packets/elementary/functions/` rather than trusting this number) |
| Level breakdown | roughly even split between L0_elementary and L1_proof_basics |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/functions/`; this file previously
grew an unbounded per-packet bullet list and has been condensed (same fix
already applied to the combinatorics, induction, and inequalities
dashboards this session). Highlights: the domain's original 16 packets
were all `abs`/`max`/`min` identities despite its stated focus being
injective/surjective/composition/inverse/monotone/fixed-point/image-
preimage basics; every one of those focus topics now has at least one
packet (`injective_comp`, `surjective_comp`, `id_bijective`,
`linear_injective`, `strictMono_injective`, `monotone_comp`,
`fixed_point_id`, and this cycle's `image_union`, the domain's first
image/preimage packet).

Next targets: see `QUEUE.md`.
