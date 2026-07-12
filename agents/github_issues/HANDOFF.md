# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-12
- Issue worked: #6 (MCIP importer, packet enrichment workflow, backfill report) — done, see
  `DONE.md`. #1-#5 done earlier in the same continuous /loop run, prior entries.
- State left in: everything from #1-#5, plus `tools/import_mcip.py` (CLI),
  `tools/mathcorpus/mcip_import.py` (shared fold logic + `import_restriction_profile`),
  `tools/backfill_report.py`, `author_packet.py` (`verifier_export_bundle` spec field +
  `_fold_verifier_export`), `tools/mathcorpus/policy.py`
  (`check_trajectory_artifact_resolution`, opt-in via `validate_packets.py
  --artifact-index`), two cross-cutting schema fixes found via integration testing
  (MCIP `empirical_difficulty_aggregate.calibration_version` was missing; packet
  `proof_variant.model_run_id` was missing), `.github/workflows/ci.yml` (2 new steps),
  `docs/mcip-import.md` (new), `manifests/backfill_report.json` (one committed snapshot —
  like the other `manifests/*.json` files, this is a point-in-time report, not kept in sync
  per-commit; regenerate via `tools/backfill_report.py`). Committed locally on `main`.
  **Still not pushed** — same pre-existing ~220-commits-ahead-of-origin situation; push
  still needs explicit confirmation from the repo owner.
- Honest scope note carried into the issue #6 close-out comment: "require provenance
  claims to resolve to trajectory/artifact records" is implemented as an opt-in policy hook
  (`--artifact-index`), not a default-on gate, because no real artifact index exists in this
  environment yet. The backfill is real but partial for the same reason — no retained Proof
  Search trajectory database is reachable here, so `attempts_and_diagnostics` and
  `model_hashes_tokens_cost_timing` report `unrecoverable_missing` for nearly every
  pre-existing packet. This is not a shortcut being silently taken; it's documented
  explicitly per-field in the backfill report itself and in `docs/mcip-import.md`.
- Next step: #1-#6 are all done — the entire MCIP roadmap's schema/tooling core is built.
  Remaining: #7 (literature-lineage, idea-attribution, prior-art records) needs brand new
  schemas — `LiteratureSource`, `RetrievedPassage`, `ExternalClaim`, `IdeaAttribution`,
  `PriorArtMatch`, `CitationReview`, `ContributionStatement` — beyond MCIP's original 10
  record types from #1; read the full issue body again before starting rather than relying
  on the earlier triage summary (`gh issue view 7 --repo Mnehmos/mathcorpus`). #8
  (publication policy) explicitly depends on #7's attribution records existing first, so do
  #7 before #8. Given #7 needs new MCIP-layer schema design (not just embedding what #1
  already built, unlike #2-#6), budget it similar attention to #1 — read `schema/mcip/v1/`
  conventions first (envelope pattern, hashing, fixtures) and follow the same shape.
