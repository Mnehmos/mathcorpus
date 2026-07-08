# Queue — Algebra (Elementary)

Candidate packets to create or formalize next, roughly in priority order.
Checked against the 41 existing packets (2026-07-07) to avoid duplicates.

## Done (this cycle)

- [x] `pow_add` — `x ^ (m + n) = x ^ m * x ^ n` (D0, L0). Authored
      2026-07-08 via tracked episode `fa0521fa-5205-4059-9071-c5519c5f3392`
      (kernel_verified on the first attempt: `ring`).

- [x] `pow_mul` — `x ^ (m * n) = (x ^ m) ^ n` (D0, L0). Authored
      2026-07-08 via tracked episode `13c20f38-d366-44f6-95be-95d9216d102d`
      (kernel_verified on the second attempt: `exact pow_mul x m n`). A
      bare `ring` attempt genuinely timed out after 60s (unlike `pow_add`,
      `ring` cannot cheaply normalize a *product* of two variable
      exponents) and is preserved as
      `packets/negative/algebra/pow_mul_ring_timeout_failure.v1.json`.

- [x] `neg_sq` — `(-a) ^ 2 = a ^ 2` (D0, L0). Authored 2026-07-08 by a
      concurrent agent (commit `bd04c9d`) — this file hadn't been synced
      to reflect it until now; fixed to prevent a duplicate re-proof
      attempt.

- [x] `sub_mul` — `(a - b) * c = a * c - b * c` (D0, L0). Authored
      2026-07-08 by a concurrent agent (commit `0427733`) — same sync fix
      as `neg_sq` above.

- [x] `div_add_div_same` — `a / c + b / c = (a + b) / c` for a field (D0,
      L0). Authored 2026-07-08 by a concurrent agent (commit `dbc6e6a`) —
      this file hadn't been synced to reflect it until now; fixed to
      prevent a duplicate re-proof attempt.

- [x] `quad_formula_real_root` — nonnegative discriminant implies a real
      root (L1, builds on `quad_form_nonneg`). Authored 2026-07-08 via
      tracked episode `9435347e-fd20-4198-aa9c-7252a8499a93`
      (kernel_verified on the third attempt: `nlinarith [hs]` couldn't
      expand the needed product; `linear_combination hs` then failed with
      a `ring`-can't-see-through-`Real.sqrt` atom mismatch after
      `field_simp` reordered the sqrt's argument; fixed by `set`-ing the
      sqrt term to a plain variable *before* `field_simp`/
      `linear_combination` so both tactics only see one opaque atom — see
      the packet's `notes`).

- [x] `add_sq_three` — `(a + b + c) ^ 2 = a^2+b^2+c^2+2ab+2bc+2ca` (D1, L1).
      Authored 2026-07-08 by a concurrent agent (commit landing
      `elementary.algebra.add_sq_three.v1`) — this agent independently
      kernel-verified the identical statement in a separate tracked
      episode (`a3bdf47a-6539-438d-bc19-bdeaa8f53d85`) moments later but
      found the packet already existed on disk; not duplicated.

- [x] `pow_succ'` — `x ^ (n + 1) = x ^ n * x` (D0, L0). Authored
      2026-07-08 via tracked episode `869150c9-d993-498d-94d3-d6f4c94cfd30`
      (kernel_verified on the first attempt: `ring`). Small but reusable
      in induction successor-case proofs.

## Next targets

*(empty — this cycle's items were the last two open in this file.
Re-derive fresh targets from `git log --oneline -15 --
packets/elementary/algebra/` before assuming this stays empty, given
heavy concurrent-agent activity on this domain.)*

## Backlog

- [ ] Sum of a finite geometric series, closed form — already effectively
      covered elsewhere in the corpus:
      `packets/elementary/induction/geom_series_sum_induction.v1.json`
      (over ℤ) and `packets/elementary/functions/geom_series_mul.v1.json`
      (over ℝ) both prove `(∑ i ∈ range n, r^i) * (r - 1) = r^n - 1`. Only
      author an `algebra`-domain version if a genuinely different proof
      style or statement shape is wanted; otherwise this item is done.
