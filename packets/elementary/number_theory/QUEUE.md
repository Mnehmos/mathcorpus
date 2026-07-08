# Queue — Number Theory (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 48 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `dvd_lcm_left` / `dvd_lcm_right` — `a ∣ Nat.lcm a b` (D0, L0). Pairs
      with `lcm_comm` (done, see below).
- [ ] `gcd_mul_lcm` — `Nat.gcd a b * Nat.lcm a b = a * b` (D1, L1). The
      classic identity tying the two families together; good reusable
      lemma for the `core_algebra`/`ring_automation` kits.

## Done (this cycle)

- [x] `not_prime_one` — `¬ Nat.Prime 1` (D0, L0). Authored 2026-07-08 via
      tracked episode `ec66cf9d-8d79-4e2c-9178-e016e854a709`
      (kernel_verified on the first attempt: `norm_num`). Pairs with
      `prime_two`.

- [x] `prime_dvd_mul` — `p.Prime -> (p ∣ a * b <-> p ∣ a ∨ p ∣ b)` (D1,
      L1). Authored 2026-07-08 by a concurrent agent (commit `7cc9f60`) —
      this file hadn't been synced to reflect it until now; fixed to
      prevent a duplicate re-proof attempt.

- [x] `lcm_comm` — `Nat.lcm a b = Nat.lcm b a` (D0, L0). Authored
      2026-07-08 by a concurrent agent (commit `ab325b5`) — this file
      hadn't been synced to reflect it until now; fixed to prevent a
      duplicate re-proof attempt.

- [x] `even_sq` — `Even (n ^ 2) <-> Even n` (D1, L1). Authored 2026-07-08
      via tracked episode `5bbacd66-df54-4a0f-9dd7-d2aa08b946ba`
      (kernel_verified on the first attempt: `Nat.even_pow' (by
      norm_num)`). The classic fact from the standard irrationality-of-
      sqrt-2 proof pattern.

- [x] `prime_two` — `Nat.Prime 2` (D0, L0). Authored 2026-07-08 via
      tracked episode `86b4db53-554e-4887-a579-adfc290a0cb5`
      (kernel_verified on the first attempt: `norm_num`). The domain's
      first primality (`Nat.Prime`) fact — closes the previously-flagged
      "no primality packets at all" gap.

- [x] `well_ordering` — every nonempty `Set ℕ` has a least element (D1,
      L1). Authored 2026-07-08 via tracked episode
      `96e95cc1-bdbf-41b7-b71d-cadd6ed1109a` (kernel_verified on the
      second attempt: `Nat.strong_induction_on` + `by_cases`/`push_neg`;
      the first attempt used the identical script under the default
      `flat_tactic_sequence` transport and kernel-failed on a bullet
      case-block hazard, fixed by resubmitting under
      `proof_format: raw_lean_block`).

## Backlog

- [ ] Bezout-style: `gcd a b` expressible as an integer linear combination
      of `a`, `b` (L2 — needs `Int`, more involved than the current
      `Nat`-only coverage).
