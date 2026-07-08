# Queue — Functions (Elementary)

Candidate packets to create or formalize next, roughly in priority order.

Per-packet history lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/functions/`; this file's "Done"
list previously grew an unbounded, repeatedly-headered bullet list
(matching the same growth pattern already fixed elsewhere this session)
and has been condensed here.

## Done (condensed)

The domain's original 16 packets were all `abs`/`max`/`min` identities
despite the `README.md`-stated focus being injective/surjective/
composition/inverse/monotone/fixed-point/image-preimage basics. That gap
is now closed and then some: `injective_comp`, `surjective_comp`,
`id_bijective`, `linear_injective` (+ `linear_injective_concrete_instance`),
`strictmono_injective`, `strictmono_comp`, `monotone_comp`,
`fixed_point_id`, `image_union` (first image/preimage packet),
`preimage_inter`, `min_le_max` (fills a real min/max-family gap), and
this cycle's `image_inter_subset` (`f '' (s ∩ t) ⊆ f '' s ∩ f '' t` —
deliberately the always-true *subset* statement, not the false
unconditional equality; tracked episode
`6eaaf620-beae-4f46-82c5-7269ae10c876`, kernel_verified on the first
attempt via `Set.image_inter_subset`).

## Next targets

*(empty — every focus-list topic from the domain's README now has
multiple packets.)*

## Backlog

*(empty)*
