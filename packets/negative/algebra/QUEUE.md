# Queue — Algebra (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(17/25 corpus-wide as of 2026-07-08) — prioritize this lane highly.
Candidates below are hypotheses to verify via a real tracked episode, not
pre-asserted facts.

## Next targets

*(empty — see Backlog)*

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
- [x] **ring on a division identity without field_simp.**
      `frac_sum_bare_ring_missing_field_simp.v1.json` — bare `ring` fails
      on `1/a + 1/b = (a+b)/(a*b)` for nonzero a, b; `field_simp; ring`
      closes it. Verified live via tracked episode
      `580850dc-88c1-464d-8b21-d4d02a1f3631`, 2026-07-08. Companion
      positive packet:
      `elementary.algebra.sum_reciprocals_eq_sum_over_product.v1`. The
      hypothesized failure did occur (ring cannot use the nonzero
      hypotheses to cancel `a * a⁻¹`/`b * b⁻¹`), so this queue item's own
      caveat about a possible false hypothesis didn't apply here.
- [x] **ring on a division-cancellation identity, second instance.**
      `div_mul_cancel_bare_ring_no_hypothesis_failure.v1.json` — bare
      `ring` fails on `a / b * b = a` for nonzero `b`, reducing to the
      unsolved residual `a * b * b⁻¹ = a` (ring cannot use `b ≠ 0` to
      cancel `b * b⁻¹`); `field_simp` closes it. Verified live via tracked
      episode `e292756d-c2f5-4bf4-a211-8b827e3751d4`, 2026-07-08. Landed
      independently of and concurrently with the `frac_sum_bare_ring_missing_field_simp`
      entry above (different concrete statement, same underlying
      ring-ignores-hypotheses lesson) — kept both rather than discarding
      already-verified tracked evidence; distinct `packet_id`s, no schema
      collision.
