# Statement Fidelity — Formal Conjectures

A packet is training-eligible only after all of the following are recorded:

- [ ] Statement fidelity review (`source_provenance.statement_fidelity`
      set honestly; does the Lean statement match the original claim?)
- [ ] Source attribution (see `SOURCE_MAP.md`)
- [ ] Proof verification (Lean-checked via a tracked episode, no unexpected
      `sorry`)
- [ ] Redaction policy applied (`python tools/redaction_audit.py`)
- [ ] `training.eligibility` recorded deliberately

| Packet | Fidelity reviewed by | Date | Verdict |
|--------|------------------------|------|---------|
| `equational_theories_677_255_class_free.v1` | repo self-review (this agent) | 2026-07-08 | `adapted_with_review` — restates the upstream `Equation255_not_implies_Equation677` avoiding its non-load-bearing `Magma` typeclass; checked by hand that the statement is definitionally identical after unfolding `Magma.op`/`Equation255`/`Equation677`. Proof kernel-verified (episode `39013082-f757-41f2-b26b-420d7577a454`). `training.eligibility: quarantined` pending real external review. |
| `oeis_a34693_exists_k_best_possible.v1` | repo self-review (this agent) | 2026-07-08 | `adapted_with_review` — restates the upstream `exists_k_best_possible` using `Real.rpow` (`n ^ (74/100:ℝ)`) instead of `Real.nthRoot 100 n ^ 74`, which does not resolve under this repo's pinned Mathlib; checked by hand that `nthRoot 100 n ^ 74 = n^(74/100)` for `n ≥ 0`, so the restatement is mathematically identical. Proof kernel-verified (episode `406c3860-6fcf-40b3-82a5-4a3a1726a89f`). `training.eligibility: quarantined` pending real external review. |
| `oeis_a358684_conjecture_0.v1` | repo self-review (this agent) | 2026-07-08 | `adapted_with_review` — inlines the upstream `a n` def as its closed form directly in the root statement (checked by hand: substituting the upstream `def a` literally into the theorem gives an identical statement). Proof independently constructed and kernel-verified (episode `8bf75cf7-35f9-4c10-8015-3a9411a6df52`) rather than transported verbatim, since the upstream file's own proof script for this theorem opens with `delta fermatNumber and a`, which appears to contain a stray/erroneous `and` token. `training.eligibility: quarantined` pending real external review. |
