# Queue — Combinatorics (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

*(empty — see Backlog)*

## Backlog

- [ ] (empty)

## Done

- [x] **False generalization: card_union without disjointness.**
      `card_union_no_disjoint_false_generalization.v1.json` — `simp` fails
      on `∀ s t : Finset ℕ, (s ∪ t).card = s.card + t.card`; falseness
      kernel-verified separately via witness `s = t = {0}` in the companion
      positive packet `elementary.combinatorics.card_union_not_additive.v1`.
      Verified live via tracked episodes `2e76ae52-...` (failed attempt)
      and `f2bb04ed-...` (kernel_verified disproof), 2026-07-08.
- [x] **simp on a filter with a non-reducible decidability instance.**
      `filter_prime_simp_no_progress.v1.json` — bare `simp` makes no
      progress on `((Finset.range 10).filter Nat.Prime).card = 4`;
      `decide` closes it. Verified live via tracked episode
      `d7f066f6-d930-417e-8988-390c84166574`, 2026-07-08. Companion
      positive packet: `elementary.combinatorics.primes_below_ten_card.v1`.
- [x] **`omega`/`decide` on a `Finset.card` goal needing
      `card_image_of_injective`.** `card_image_injective_omega_failure.v1.json`
      — bare `omega` cannot use a `Function.Injective f` hypothesis to
      relate `(s.image f).card` and `s.card`;
      `Finset.card_image_of_injective` closes it. Verified live via
      tracked episode `5f59b5d8-e34b-4def-9892-5ba68f409d7b`, 2026-07-08.
      Companion positive packet:
      `elementary.combinatorics.card_image_of_injective.v1`.
