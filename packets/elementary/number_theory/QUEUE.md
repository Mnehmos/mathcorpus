# Queue — Number Theory (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 48 existing packets (2026-07-07) to avoid duplicates.

## Next targets

- [ ] `lcm_comm` — `Nat.lcm a b = Nat.lcm b a` (D0, L0). The domain has a
      full `gcd_*` family (`gcd_comm'`, `gcd_dvd_left'`, `gcd_dvd_right'`,
      `gcd_mul_left'`, `gcd_one_right'`, `gcd_self'`, `gcd_zero_left'`) but
      **no `lcm_*` packets at all** — this is the biggest single naming gap
      in the domain.
- [ ] `dvd_lcm_left` / `dvd_lcm_right` — `a ∣ Nat.lcm a b` (D0, L0). Pairs
      with `lcm_comm`.
- [ ] `gcd_mul_lcm` — `Nat.gcd a b * Nat.lcm a b = a * b` (D1, L1). The
      classic identity tying the two families together; good reusable
      lemma for the `core_algebra`/`ring_automation` kits.
- [ ] `prime_two` — `Nat.Prime 2` (D0, L0). The domain has `even_or_odd'`
      and extensive `coprime_*`/`gcd_*` coverage but **no primality
      packets at all** — no `Nat.Prime` fact exists yet.
- [ ] `not_prime_one` — `¬ Nat.Prime 1` (D0, L0). Pairs with `prime_two`.
- [ ] `prime_dvd_mul` — `p.Prime -> (p ∣ a * b <-> p ∣ a ∨ p ∣ b)` (D1,
      L1). The single most reusable primality lemma for later divisibility
      work; natural next step after `prime_two`.
- [ ] `even_sq` — `Even (n ^ 2) <-> Even n` (D1, L1). The domain has
      `even_mul_right`, `even_mul_succ_self`, `odd_add_odd` but not the
      classic "n even iff n^2 even" fact used in the standard irrationality
      proof pattern.

## Done (this cycle)

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
