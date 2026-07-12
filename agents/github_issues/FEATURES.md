# Features — Dev Issues

| Issue | Summary | Motivation | Status | Notes |
|-------|---------|------------|--------|-------|
| #1 | Define MCIP v1 (10 record types, hashing/versioning rules, conformance fixtures) | Shared interchange contract with `llm-driven-proof-search`, independent of its SQLite schema | done | `schema/mcip/v1/`, `tools/validate_mcip.py`, `tools/gen_mcip_fixtures.py`. Foundation for #2-#7. |
| #2 | Proof profiles, restriction profiles, proof variants on packets | Packets can't distinguish proof strategy or represent multiple proof styles | open | MCIP shapes exist (`proof_profile`, `restriction_profile`, `proof_variant` schemas); this issue is embedding them as packet child records in `packet.schema.json` + migrating 5 fixture packets. |
| #3 | Standardize dependency manifests and retrieval evidence | `dependencies` is too shallow; `author_packet.py` doesn't populate real usage | open | MCIP `dependency_manifest` shape exists; this issue wires it into packets + `author_packet.py`. |
| #4 | Negative-example and repair-trajectory child records | Only a minimal `failure` summary today; no repair chains | open | MCIP `negative_example`/`repair_trajectory`/`attempt_record` shapes exist; this issue embeds them at the packet level. |
| #5 | Multi-model empirical difficulty + native analytics exports | `difficulty_bin` is author-assigned only; enrichment hidden in nested JSON | open | MCIP `model_run`/`empirical_difficulty_aggregate` shapes exist; this issue adds packet-level aggregation + native Parquet/JSONL columns. |
| #6 | MCIP importer, packet enrichment workflow, 190-packet backfill | Make enriched Proof Search output the default population path | open | Depends on #1 (done) and, for full field coverage, #2-#5. Needs dry-run/validate/conflict-detect/resumable importer + loss report. |
| #7 | Literature-lineage, idea-attribution, prior-art records | Packet-level provenance isn't enough for AI-assisted proofs | open | New MCIP-compatible child schemas (`LiteratureSource`, `RetrievedPassage`, etc.) not yet defined — out of #1's original 10 record types. |
| #8 | Contribution/citation/novelty review policy for open-problem exports | Kernel-verified isn't the same as publication-ready | open | Policy-only; depends on #7's attribution records existing first. |
