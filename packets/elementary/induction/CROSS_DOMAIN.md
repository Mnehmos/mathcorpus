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

If a pattern is used by more than one domain, propose promoting it — see
`agents/CROSS_DOMAIN_PROMOTIONS.md`.
