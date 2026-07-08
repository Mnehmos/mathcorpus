# Queue — Number Theory (Elementary)

Candidate packets to create or formalize next, roughly in priority order.

Per-packet history lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/number_theory/`; this file's "Done"
list previously grew an unbounded, repeatedly-headered bullet list
(matching the same growth pattern already fixed elsewhere this session)
and has been condensed here.

## Done (condensed)

`prime_two`, `not_prime_one`, `prime_dvd_mul` (this domain's first
primality family), `lcm_comm`, `gcd_mul_lcm` (`Nat.gcd a b * Nat.lcm a b
= a * b`, ties the `gcd_*`/`lcm_*` families together, tracked episode
`f6352ddf-5a46-4adf-ac9a-4036cb887f47`, kernel_verified on the first
attempt via `Nat.gcd_mul_lcm`), `even_sq`, `well_ordering` (the naturals'
well-ordering principle — see this packet's `notes` for a bullet/
`raw_lean_block` transport lesson), `dvd_lcm_left'`/`dvd_lcm_right'`
(`a ∣ Nat.lcm a b` / `b ∣ Nat.lcm a b`; trailing apostrophe avoids
shadowing Mathlib's own `Nat.dvd_lcm_left`/`Nat.dvd_lcm_right`).

## Next targets

*(empty)*

## Backlog

- [ ] Bezout-style: `gcd a b` expressible as an integer linear combination
      of `a`, `b` (L2 — needs `Int`, more involved than the current
      `Nat`-only coverage).
