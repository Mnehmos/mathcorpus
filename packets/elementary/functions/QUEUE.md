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
packet's `notes`), `preimage_inter` (the suggested preimage counterpart),
and `strictmono_comp` (composition of two strictly monotone functions is
strictly monotone, kernel_verified on the first attempt via tracked
episode `21aeb6a1-40c0-485b-8bee-abf5530eb0c5`, completing the
monotone-family cluster). Also `min_le_max` (D0, L0) — `min a b <= max a
b`, kernel_verified on the first attempt via tracked episode
`562a07a3-c952-4735-9573-2fd802b87e12` (`le_max_of_le_left (min_le_left a
b)`); fills a real gap between the existing `max_comm`/`max_self`/
`min_comm`/`min_self` family, none of which directly relate min and max.

## Next targets

*(empty — every focus-list topic from the domain's README now has
multiple packets. Good next candidate: `image_inter` (image of an
intersection is a *subset* of, not equal to, the intersection of images —
would need a counterexample-based negative example or a careful
non-injective-function caveat).)*

## Backlog

*(empty)*
