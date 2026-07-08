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
