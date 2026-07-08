# Queue — Algebra (Negative Examples)

Candidate packets to create or formalize next, roughly in priority order.

## Next targets

- [ ] `field_simp`-skipped division identity: attacking a `Field`/`ℝ`
      equation containing bare division with `ring` before clearing
      denominators, illustrating when `ring` alone suffices vs. when
      `field_simp` is needed first (only if a genuine failure case exists —
      `ring` does normalize `DivisionRing` division formally in many cases,
      so verify via a tracked episode before assuming it fails).
- [ ] `nlinarith`/`positivity` mismatch on a goal requiring case-split on
      sign (e.g. an inequality that's false without a hypothesis bound).

## Backlog

- [ ]

## Done

- [x] `nat_sub_ring_trap.v1` — `ring` on `ℕ` truncated subtraction with an
      unused hypothesis (2026-07-08).

Update this file after every completed packet (remove the item) and
whenever a new candidate is identified (add it, with a one-line reason it's
useful).
