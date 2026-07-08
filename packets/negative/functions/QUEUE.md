# Queue — Functions (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] A false "converse" statement: attempting to prove every surjective
      function between two `Finset`-backed finite types of equal
      cardinality is automatically injective **without** invoking the
      finite-cardinality lemma that makes it true (i.e. via a tactic that
      can't see finiteness) — verify the concrete failure mode before
      adding; if the natural tactic just succeeds, this isn't a valid
      negative example.

## Backlog

- [ ] Companion positive packet for the quadratic injectivity goal below
      (`Function.Injective (fun n : ℕ => n ^ 2 + n)`) — needs an explicit
      `intro a b h` plus trichotomy case split or a `StrictMono.injective`
      argument, not yet attempted.

## Done

- [x] **simp-unfold on Function.Injective leaves an open goal.**
      `quad_injective_simp_unfold_incomplete.v1.json` — `simp
      [Function.Injective]` on `Function.Injective (fun n : ℕ => n ^ 2 +
      n)` unfolds the definition but leaves the quadratic implication
      unsolved. Verified live via tracked episode
      `6ae6dffb-77c7-4873-9d7a-be0dd4bf03b8`, 2026-07-08. Note: the
      *linear* instance of this same hypothesis
      (`fun n : ℕ => 3 * n + 7`) turned out to be FALSE — bare `simp
      [Function.Injective]` kernel-verified it outright (episode
      `9c3f7163-...`) — so a linear target is not a valid candidate for
      this failure mode; use a non-cancellable (quadratic or higher)
      target instead.
