# Queue — Algebra (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **nlinarith without an SOS hint on a two-variable square bound.**
      Attempt `nlinarith` (no hints) directly on `a^2 + b^2 >= 2*a*b`.
      Expected failure mode: `nlinarith` cannot synthesize the
      `sq_nonneg (a - b)` auxiliary term on its own and fails/times out;
      the fix is `nlinarith [sq_nonneg (a - b)]`. gap_category:
      `tactic_mismatch`, sub_category: `nlinarith_missing_sos_hint`.
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
