# Dashboard — Algebra (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 49+ (multiple concurrent agent instances committing every cycle — re-derive via `python tools/corpus_stats.py`) |
| Level breakdown | mostly L0_elementary, some L1_proof_basics/L2_olympiad |

Last synced: 2026-07-08 — added `pow_succ'` (D0, L0, episode
`869150c9-d993-498d-94d3-d6f4c94cfd30`): `x^(n+1) = x^n * x` via `ring`,
small but reusable in induction successor-case proofs — this closes the
domain's `QUEUE.md` "Next targets" list entirely for now (`add_sq_three`
landed independently via a concurrent agent moments before this cycle's
own duplicate attempt was caught pre-authoring). Also present: `pow_mul`
(episode `13c20f38-d366-44f6-95be-95d9216d102d`, paired negative example
`pow_mul_ring_timeout_failure`), `pow_add`, `neg_sq`, `sub_mul`,
`div_add_div_same`, `quad_formula_real_root` (concurrent agents +
earlier this session). Re-sync against `agents/status/MATHCORPUS_STATUS.md`
and `python tools/corpus_stats.py` after adding packets.

Next targets: see `QUEUE.md`.
