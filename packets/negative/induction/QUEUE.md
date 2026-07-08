# Queue — Induction (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **induction without generalizing an auxiliary variable, take 2.**
      The obvious instance -- `l.foldl (fun a x => x :: a) acc = l.reverse
      ++ acc` proved by `induction l` (acc fixed, not generalized), closing
      each case with `simp [ih]` -- was tried live via tracked episode
      `0ab12a3b-a0fb-4981-b6fe-63628a4f6fb6` and it actually
      **kernel_verified**: `simp` is strong enough to bridge the
      accumulator shift on its own, so this specific hypothesis is false
      and was authored as a positive packet instead
      (`elementary.induction.foldl_cons_eq_reverse_append.v1`). To get a
      genuine failure, close with a *weaker* tactic that can't rewrite
      through the accumulator mismatch on its own -- e.g. `rfl` or `exact
      ih` alone in the `cons` case (expect the IH's fixed `acc` to not
      unify with the goal's `x :: acc`) -- rather than `simp [ih]`.
      gap_category: `tactic_mismatch`, sub_category:
      `induction_without_generalizing`.

## Backlog

- [ ] Off-by-one base case error: attempt an induction proof starting at
      `n = 0` for a statement that's only true from `n = 1` or `n = 2`
      onward (verify a concrete false-at-the-boundary instance before
      adding — this must be a real gap, not a fixable base-case tweak).
