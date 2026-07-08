# Cross-Domain Dependencies — Induction (Elementary)

Record any lemma, kit, or proof pattern this domain borrows from — or lends
to — another domain or shared kit family (`dependencies.kits` in the
packet schema — e.g. `core_algebra`, `ring_automation`,
`PowerSeriesKit`, `RecurrenceGeneratingFunctionKit`,
`InequalityEstimateKit`, `AffineAreaKit`, `GeometryAngleKit`,
`FiniteConvexityKit`, `ExtremalCombinatoricsKit`, `FiniteCertificateKit`).

| Date | Packet | Depends on / Lends to | Domain/Kit | Notes |
|------|--------|--------------------------|------------|-------|
| 2026-07-08 | `elementary.induction.bernoulli_inequality.v1` | Depends on | `InequalityEstimateKit` (owned by `packets/elementary/inequalities/`) | Uses the `mul_le_mul_of_nonneg_right` / `sq_nonneg` nonnegativity-bridging pattern that kit's packets already rely on; the induction proof itself is domain-native, only the successor-step inequality bridge borrows the pattern. |
| 2026-07-08 | `elementary.induction.factorial_ge_two_pow.v1` | Related to | `number_theory` (`packets/elementary/number_theory/factorial_pos.v1.json`, `factorial_le.v1.json`) | Same `Nat.factorial` subject matter as those number_theory packets, but no direct proof-term dependency — this packet's induction proof only uses `Nat.factorial_succ` and `Nat.factorial_pos` directly from Mathlib. Cross-referenced for curriculum sequencing, not code reuse. |

If a pattern is used by more than one domain, propose promoting it — see
`agents/CROSS_DOMAIN_PROMOTIONS.md`.
