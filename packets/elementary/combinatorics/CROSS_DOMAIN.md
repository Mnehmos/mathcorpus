# Cross-Domain Dependencies — Combinatorics (Elementary)

Record any lemma, kit, or proof pattern this domain borrows from — or lends
to — another domain or shared kit family (`dependencies.kits` in the
packet schema — e.g. `core_algebra`, `ring_automation`,
`PowerSeriesKit`, `RecurrenceGeneratingFunctionKit`,
`InequalityEstimateKit`, `AffineAreaKit`, `GeometryAngleKit`,
`FiniteConvexityKit`, `ExtremalCombinatoricsKit`, `FiniteCertificateKit`).

| Date | Packet | Depends on / Lends to | Domain/Kit | Notes |
|------|--------|--------------------------|------------|-------|
| 2026-07-08 | `card_union_add_card_inter.v1` | Depends on | `ExtremalCombinatoricsKit` | Same kit as `card_union_le.v1`; pairs the exact inclusion-exclusion identity with the existing inequality. |
| 2026-07-08 | `disjoint_union_card.v1` | Depends on | `ExtremalCombinatoricsKit` | Equality companion to `card_union_le.v1`; sets up the negative-example candidate showing the equality is false without the `Disjoint` hypothesis. |

If a pattern is used by more than one domain, propose promoting it — see
`agents/CROSS_DOMAIN_PROMOTIONS.md`.
