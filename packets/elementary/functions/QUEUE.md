# Queue — Functions (Elementary)

Candidate packets to create or formalize next, roughly in priority order.

Per-packet history lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/functions/`; this file's "Done"
list previously grew an unbounded, repeatedly-headered bullet list
(matching the same growth pattern already fixed in the combinatorics,
induction, and inequalities dashboards/queues this session) and has been
condensed here.

## Done (condensed)

The domain's original 16 packets were all `abs`/`max`/`min` identities
despite the `README.md`-stated focus being injective/surjective/
composition/inverse/monotone/fixed-point/image-preimage basics. That gap
is now closed: `injective_comp`, `surjective_comp`, `id_bijective`,
`linear_injective` (general `a != 0` form) + `linear_injective_concrete_instance`,
`strictmono_injective`, `monotone_comp`, `fixed_point_id`, and this
cycle's `image_union` (`f '' (s ∪ t) = f '' s ∪ f '' t`, the domain's
first image/preimage packet — cited directly via `Set.image_union` after
two bullet-transport-hazard failures on a hand-unfolded attempt; see the
packet's `notes`).

## Next targets

*(empty — every focus-list topic from the domain's README now has at
least one packet. Good next candidates: a preimage counterpart to
`image_union` (e.g. `f ⁻¹' (s ∩ t) = f ⁻¹' s ∩ f ⁻¹' t`), or a second
`monotone`-family lemma beyond `monotone_comp`/`strictMono_injective`.)*

## Backlog

*(empty)*
