# Dashboard — Functions (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 19+ |
| Level breakdown | L0_elementary: 9+ · L1_proof_basics: 10+ |

Last synced: 2026-07-08 — added `injective_comp` (D1, L1, episode
`ab41c15c-582d-481c-967c-c9daa8439bac`): composition of two injective
functions is injective, proved directly by unfolding `Function.Injective`.
This is the domain's first packet on its stated focus (injective/
surjective/composition/inverse/monotone/fixed-point basics) — the prior 16
were all `abs`/`max`/`min` identities. Also added `surjective_comp` (D1,
L1, episode `fd3f917e-f58b-4077-90da-bb1c3d62c203`): composition of two
surjective functions is surjective, kernel_verified on the first attempt.
Also added `id_bijective` (D0, L0, episode
`7bce298c-c66f-4696-a952-c7f82691c46a`): the identity function is
bijective, kernel_verified on the second attempt (first hit a
bullet/flat-transport case-block issue, see the packet's `notes`). Other
concurrent agents are actively landing `linear_injective` /
`strictMono_injective` in this same domain right now — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
rather than trusting this count exactly.

Next targets: see `QUEUE.md`.
