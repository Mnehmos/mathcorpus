# Queue — Induction (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

*(empty — see Backlog)*

## Backlog

- [ ] Off-by-one base case error: attempt an induction proof starting at
      `n = 0` for a statement that's only true from `n = 1` or `n = 2`
      onward (verify a concrete false-at-the-boundary instance before
      adding — this must be a real gap, not a fixable base-case tweak).

## Done

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
