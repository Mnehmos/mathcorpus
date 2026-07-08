# Queue — Induction (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **induction without generalizing an auxiliary variable.** Pick a
      statement whose induction hypothesis is too weak because a second
      variable wasn't generalized first (e.g. a statement `P n m` proved by
      `induction n` where the successor case actually needs the claim for
      an arbitrary `m`, not the fixed one in scope). Expected failure mode:
      the successor case's goal doesn't match the available IH and the
      proof gets stuck; the fix is `induction n generalizing m".
      gap_category: `tactic_mismatch`, sub_category:
      `induction_without_generalizing`.

## Backlog

- [ ] Off-by-one base case error: attempt an induction proof starting at
      `n = 0` for a statement that's only true from `n = 1` or `n = 2`
      onward (verify a concrete false-at-the-boundary instance before
      adding — this must be a real gap, not a fixable base-case tweak).
