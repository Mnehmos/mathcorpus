# Queue — Functions (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

*(empty — see Backlog)*

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
- [x] **False converse: surjective implies injective, misapplied to an
      infinite domain.**
      `surjective_implies_injective_finite_pigeonhole_misapplied.v1.json`
      — `simp [Function.Injective]` on `∀ f : ℕ → ℕ, Surjective f →
      Injective f` correctly leaves the goal unsolved (the claim is
      false without finiteness); falseness kernel-verified separately via
      witness `f n = n - 1` in the companion positive packet
      `elementary.functions.surjective_not_always_injective.v1`. Verified
      live via tracked episodes `a1bfdf14-...` (failed attempt) and
      `0b3fa2fb-...` (kernel_verified disproof), 2026-07-08.
