# Queue — Number Theory (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **omega on a gcd-divisibility goal.** Attempt `omega` directly on
      `Nat.gcd a b ∣ a`. Expected failure mode: `omega` has no theory of
      `Nat.gcd` and cannot see the goal as linear arithmetic at all; the
      fix is `Nat.gcd_dvd_left`. gap_category: `tactic_mismatch`,
      sub_category: `omega_on_gcd_dvd_goals`.
- [ ] **decide on an unbounded primality-style claim.** Attempt
      `decide`/`native_decide` on a statement quantified over all `n`
      (e.g. "no `n` makes some divisibility pattern hold") rather than a
      single concrete instance. Expected failure mode: the decidability
      instance either doesn't exist or the search is unbounded; record
      whatever error actually surfaces.

## Backlog

- [ ] `simp` looping or stalling on a `Nat.mod`/`Nat.div` goal that needs
      an explicit case split first (verify a concrete instance before
      adding).

## Done

- [x] `divisor_case_split_omega_unevaluated_literal.v1` — `omega` on an
      unreduced literal divisor left by a case split (e.g. `3 + (-1) | 88`);
      `norm_num` repairs it. Verified live via a tracked episode
      (2026-07-08).
- [x] `sq_parity_omega_nonlinear_failure.v1` — `omega` directly on
      `n ^ 2 % 2 = n % 2`; treats `n ^ 2` as an opaque nonlinear atom and
      fails deterministically (`kernel_fail`/`tactic_failure`). Verified
      live via tracked episode `7381250f-097a-4151-b5ba-0e80303ff42e`
      (2026-07-08). Not identified in a prior queue pass — picked as a
      natural-but-wrong first attempt on a curriculum-standard parity
      lemma; a follow-up positive `elementary` packet for the correct
      case-split proof is still open (not attempted this cycle).

Update this file after every completed packet (remove the item) and
whenever a new candidate is identified (add it, with a one-line reason it's
useful).
