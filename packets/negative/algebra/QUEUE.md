# Queue — Algebra (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **ring on a division identity without field_simp.** Attempt `ring`
      directly on a goal mixing `/` in a way that needs clearing
      denominators first (verify what actually happens under our pinned
      Mathlib — `ring` may already normalize simple field division; if it
      succeeds, this is not a valid negative example and should be dropped
      from the queue rather than forced).

## Backlog

- [ ] A `decide`/`norm_num` timeout on a goal disguised as decidable but
      actually requiring unbounded search (verify a concrete instance
      exists before adding).

## Done

- [x] **nlinarith without an SOS hint on a two-variable square bound.**
      `sq_sum_bare_nlinarith_missing_sos_hint.v1.json` — bare `nlinarith`
      fails on `a^2 + b^2 >= 2*a*b`; `nlinarith [sq_nonneg (a - b)]`
      closes it. Verified live via tracked episode
      `42da9f6e-6693-4354-8b0b-9332b7d91def`, 2026-07-08. Companion
      positive packet: `elementary.algebra.sq_sum_ge_two_mul.v1`. Note: the
      first `problem_create` for this target used the default (base
      Ring+NormNum) import manifest and hit an unrelated "unknown tactic"
      elaboration error for `nlinarith`/`ℝ` — recreate with
      `problem_imports=["Mathlib"]` for any goal needing `nlinarith` or
      real-number types.
