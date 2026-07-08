# Queue — Combinatorics (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **simp looping on a filter with a non-reducible decidability
      instance.** Attempt `simp` on a `Finset.filter p s` goal where `p`'s
      `Decidable` instance isn't reducible by `simp`'s default set.
      Expected failure mode: `simp` leaves a residual `Decidable` goal or
      makes no progress; verify the concrete instance before adding.

## Backlog

- [ ] `omega`/`decide` timeout attempting to close a `Finset.card` goal
      that actually requires an explicit `Finset.card_image_of_injective`
      or similar structural lemma rather than computation.

## Done

- [x] **False generalization: card_union without disjointness.**
      `card_union_no_disjoint_false_generalization.v1.json` — `simp` fails
      on `∀ s t : Finset ℕ, (s ∪ t).card = s.card + t.card`; falseness
      kernel-verified separately via witness `s = t = {0}` in the companion
      positive packet `elementary.combinatorics.card_union_not_additive.v1`.
      Verified live via tracked episodes `2e76ae52-...` (failed attempt)
      and `f2bb04ed-...` (kernel_verified disproof), 2026-07-08.
