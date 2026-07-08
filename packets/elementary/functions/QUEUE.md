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

- [x] `left_inverse_injective` — a left inverse of f implies f is
      injective (D1, L1). Authored 2026-07-08 via tracked episode
      `05445672-9c21-4748-ae0e-87e87b966198` (kernel_verified on the
      first attempt). **Corrects a stale claim in this file and in
      `DASHBOARD.md`**: "every focus-list topic... has multiple packets"
      was wrong — `inverse` had zero packets (confirmed via `grep -rl
      LeftInverse\|RightInverse packets/elementary/functions/*.json`,
      no hits, before authoring). Proved directly from the
      `Function.LeftInverse` definition (`congrArg g hab` + rewrite)
      rather than citing a Mathlib convenience lemma by name, since
      `mathlib_search_declarations` results for the exact current
      lemma name were ambiguous (many unrelated `injective` hits from
      other namespaces polluted the search).

- [x] `right_inverse_surjective` — a right inverse of f implies f is
      surjective (D0, L1). Authored 2026-07-08 via tracked episode
      `6f12df1e-e85a-4160-af71-19e22e9b0384` (kernel_verified on the
      first attempt: `⟨g b, h b⟩` directly, no rewriting needed).
      Completes the "inverse" focus pair alongside `left_inverse_injective`
      — this was exactly the backlog item left last cycle for this pickup.

- [x] `bijective_comp` — the composition of two bijective functions is
      bijective (D0, L1). Authored 2026-07-08 via tracked episode
      `0b5fbe31-1b22-4719-8026-460d827dbfc7` (kernel_verified on the
      first attempt: pairing `Function.Injective.comp`/
      `Function.Surjective.comp` for each half). Completes
      `injective_comp`/`surjective_comp` with the combined `Bijective`
      statement — confirmed via `grep -rl Bijective` (only `id_bijective`
      hit, nothing about composition) before authoring.

## Next targets

*(empty — every focus-list topic genuinely has multiple packets now,
confirmed by grep, not just prose.)*

## Backlog

*(empty — v0.1's numeric release criteria (>=250 public, >=25 negative)
were both met this session; remaining work here is for quality/balance,
not raw count. Check `git log --oneline -15 --
packets/elementary/functions/` before starting a new target, since
concurrent agents work this domain too.)*
