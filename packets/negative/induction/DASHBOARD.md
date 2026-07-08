# Dashboard — Induction (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 4 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

Last synced: 2026-07-08 — added `two_pow_gt_sq_offbyone_naive_ih_failure.v1`
(tactic_mismatch, `offbyone_induction_threshold`: plain `induction n with
zero | succ` on `n >= 5 -> 2^n > n^2` invokes `ih (by omega)` assuming
`n >= 5` follows from `n + 1 >= 5` — false at the `n = 4` boundary, so
`omega` genuinely fails; `Nat.le_induction`, starting the induction at the
real threshold `n = 5`, closes the same episode
`1fea172d-06f2-447d-a2a1-94a58f47f7cd` as the companion positive packet
`elementary.induction.two_pow_gt_sq_from_five.v1`). A concurrent agent
independently added `factorial_gt_two_pow_offbyone_false_base.v1`
(`false_generalization`: unguarded `n! > 2^n` is genuinely false at
`n = 0..3`, so `decide` correctly reports the zero case false) for the
same queued backlog item — both kept (distinct concrete statements,
distinct gap_category). Also present: `pow_succ_atom_nlinarith_failure.v1`
(tactic_mismatch: nlinarith over un-rewritten `2^(n+1)`/`2^n` atoms), and
`foldl_no_generalize_ih_too_weak.v1` (tactic_mismatch,
`induction_without_generalizing`: `induction l` with `acc` fixed, closing
the `cons` case with bare `exact ih`, fails with a clean type mismatch —
`ih`'s fixed `acc` doesn't unify with the goal's `x :: acc`; "take 2" of
the same root statement as the companion positive packet
`elementary.induction.foldl_cons_eq_reverse_append.v1`, episode
`d5057978-41c6-4686-b360-a0947d8a518e`).
Re-sync against `agents/status/MATHCORPUS_STATUS.md` and
`python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
