# Cross-Domain Dependencies — Combinatorics (Negative Examples)

Record any lemma, kit, or proof pattern this domain borrows from — or lends
to — another domain or shared kit family (`dependencies.kits` in the
packet schema — e.g. `core_algebra`, `ring_automation`,
`PowerSeriesKit`, `RecurrenceGeneratingFunctionKit`,
`InequalityEstimateKit`, `AffineAreaKit`, `GeometryAngleKit`,
`FiniteConvexityKit`, `ExtremalCombinatoricsKit`, `FiniteCertificateKit`).

| Date | Packet | Depends on / Lends to | Domain/Kit | Notes |
|------|--------|--------------------------|------------|-------|
| 2026-07-08 | `finset_card_atoms_omega_failure.v1` | Depends on | `ExtremalCombinatoricsKit` | Failure references `Finset.card_union_add_card_inter` as the bridging lemma the wrong route skipped. |

If a pattern is used by more than one domain, propose promoting it — see
`agents/CROSS_DOMAIN_PROMOTIONS.md`.
