# Queue — Number Theory (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

(none currently queued — see Backlog)

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
      (2026-07-08). Follow-up positive packet now landed: `rcases
      Nat.even_or_odd n with ⟨k, rfl⟩ | ⟨k, rfl⟩ <;> ring_nf <;> omega`
      kernel-verified in tracked episode
      `d656e3da-c561-40fc-ad33-ba04213fb8ff` and authored as
      `packets/elementary/number_theory/sq_mod_two_eq_self_mod_two.v1.json`.
- [x] `gcd_dvd_omega_no_gcd_theory.v1` — `omega` on `Nat.gcd a b ∣ a`;
      omega has zero theory of `Nat.gcd`, a total gap rather than a
      normalization issue. Verified live via tracked episode
      `e92f1fe2-eedb-48d5-94c8-9695aa253fed` (2026-07-08).
- [x] `decide_unbounded_prime_universal.v1` — bare `decide` on
      `∀ n : ℕ, ¬ Nat.Prime (4 * n)`; no `Decidable` instance for an
      unbounded universal over ℕ (`kernel_fail`, elaboration failure, not
      a search timeout). Verified live via tracked episode
      `3148ceed-b740-4b21-a788-7b239face439` (2026-07-08). Companion
      positive packet: `packets/elementary/number_theory/four_mul_not_prime.v1.json`
      (`intro n hp; have h2 : (2:ℕ) ∣ 4 * n := ⟨2 * n, by ring⟩; have h3 :=
      hp.eq_one_or_self_of_dvd 2 h2; omega`).

Update this file after every completed packet (remove the item) and
whenever a new candidate is identified (add it, with a one-line reason it's
useful).
