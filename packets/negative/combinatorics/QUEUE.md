# Queue — Combinatorics (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **False generalization: card_union without disjointness.** Attempt to
      prove `(s ∪ t).card = s.card + t.card` for *general* (possibly
      overlapping) `Finset`s. This is genuinely **false** without a
      `Disjoint s t` hypothesis — the correct statement is
      `Finset.card_union_of_disjoint`, or the inequality
      `Finset.card_union_le'` already in the corpus. gap_category:
      `false_generalization`, sub_category: `missing_disjointness_hypothesis`.
      This is a different negative-example shape than a tactic-mismatch —
      the *goal itself* is unprovable, not just the first tactic tried; a
      good example of the distinction to preserve in `notes`.
- [ ] **simp looping on a filter with a non-reducible decidability
      instance.** Attempt `simp` on a `Finset.filter p s` goal where `p`'s
      `Decidable` instance isn't reducible by `simp`'s default set.
      Expected failure mode: `simp` leaves a residual `Decidable` goal or
      makes no progress; verify the concrete instance before adding.

## Backlog

- [ ] `omega`/`decide` timeout attempting to close a `Finset.card` goal
      that actually requires an explicit `Finset.card_image_of_injective`
      or similar structural lemma rather than computation.
