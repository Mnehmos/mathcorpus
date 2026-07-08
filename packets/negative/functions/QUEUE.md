# Queue — Functions (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **simp-unfold on Function.Injective leaves an open goal.** Attempt
      `simp [Function.Injective]` directly on an injectivity goal instead
      of `intro a b h` followed by algebra. Expected failure mode: `simp`
      unfolds the definition but leaves an unclosed implication that it
      cannot discharge on its own. gap_category: `tactic_mismatch`,
      sub_category: `simp_unfold_injective_incomplete`. Natural pairing
      with the `injective_comp` / `linear_injective` positive-packet
      candidates in `packets/elementary/functions/QUEUE.md`.

## Backlog

- [ ] A false "converse" statement: attempting to prove every surjective
      function between two `Finset`-backed finite types of equal
      cardinality is automatically injective **without** invoking the
      finite-cardinality lemma that makes it true (i.e. via a tactic that
      can't see finiteness) — verify the concrete failure mode before
      adding; if the natural tactic just succeeds, this isn't a valid
      negative example.
