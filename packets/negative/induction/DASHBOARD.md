# Dashboard — Induction (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 2 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

Last synced: 2026-07-08 — added `pow_succ_atom_nlinarith_failure.v1`
(tactic_mismatch: nlinarith over un-rewritten `2^(n+1)`/`2^n` atoms), and
`foldl_no_generalize_ih_too_weak.v1` (tactic_mismatch,
`induction_without_generalizing`: `induction l` with `acc` fixed, closing
the `cons` case with bare `exact ih`, fails with a clean type mismatch —
`ih`'s fixed `acc` doesn't unify with the goal's `x :: acc`. This is
"take 2" of the same root statement as the companion positive packet
`elementary.induction.foldl_cons_eq_reverse_append.v1`, episode
`d5057978-41c6-4686-b360-a0947d8a518e` — the first attempt at this
hypothesis, closing with `simp [ih]` instead, actually kernel-verified and
became that positive packet rather than a negative example).
Re-sync against `agents/status/MATHCORPUS_STATUS.md` and
`python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
