# Queue — Induction (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

*(empty — see Backlog)*

## Backlog

*(empty)*

## Done

- [x] **Off-by-one base case error** — resolved independently, twice, by
      concurrent agents:
      - `two_pow_gt_sq_offbyone_naive_ih_failure.v1.json` — the goal
        `n >= 5 -> 2^n > n^2` (false at n in {2,3,4}) attacked with plain
        `induction n with zero | succ`, whose successor case invokes
        `ih (by omega)` assuming `n >= 5` follows from `n + 1 >= 5` — false
        exactly at the `n = 4` boundary, so `omega` genuinely fails ("No
        usable constraints found"). `Nat.le_induction` (starting the
        induction at the real threshold `n = 5`) closes the same tracked
        episode `1fea172d-06f2-447d-a2a1-94a58f47f7cd` `kernel_verified` as
        the companion positive packet
        `packets/elementary/induction/two_pow_gt_sq_from_five.v1.json`.
        `tactic_mismatch` gap_category (the naive tactic is wrong; the
        underlying guarded statement is true).
      - `factorial_gt_two_pow_offbyone_false_base.v1.json` — `n! > 2^n`
        attacked via naive induction from `n = 0`; the *unguarded*
        universal claim is genuinely FALSE at `n = 0..3` (only true from
        `n = 4` onward), so the zero-case `decide` correctly reports it
        false — a clean `kernel_fail`, closed with `give_up` since no
        guard hypothesis was added. This domain's first
        `false_generalization` gap_category negative example (distinct
        from the `tactic_mismatch` example above: here the *statement*
        itself is false without a guard, not just the tactic being wrong).

- [x] **induction without generalizing an auxiliary variable, take 2.**
      `foldl_no_generalize_ih_too_weak.v1.json` — same root statement as
      the positive packet `foldl_cons_eq_reverse_append.v1`
      (`l.foldl (fun a x => x :: a) acc = l.reverse ++ acc`), but closing
      the `cons` case with bare `exact ih` (instead of `simp [ih]`) fails
      with a clean type mismatch: `ih`'s fixed `acc` doesn't unify with
      the goal's `x :: acc`. Verified live via tracked episode
      `d5057978-41c6-4686-b360-a0947d8a518e`, 2026-07-08. Take 1
      (`simp [ih]`) is documented in the companion positive packet's
      notes as the false-hypothesis case.
