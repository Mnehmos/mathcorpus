# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-12
- Issue worked: #5 (multi-model empirical difficulty + native analytics exports) — done,
  see `DONE.md`. #1-#4 done earlier in the same continuous /loop run, prior entries.
- State left in: everything from #1-#4, plus `packet.schema.json`
  (`model_runs[]`/`empirical_difficulty_aggregates[]` + their `$defs`),
  `tools/mathcorpus/difficulty.py` (versioned calibration formula),
  `tools/mathcorpus/policy.py` (`check_empirical_difficulty_aggregates`),
  `tools/mathcorpus/aggregates.py` (new, shared by `build_manifests.py` — refactored — and
  `corpus_stats.py`), `tools/export_parquet.py` (9 native derived columns), a new synthetic
  `packets/_fixtures/model_performance_conformance.v1.json` fixture (private_audit_only),
  `ENUMS.md` docs. Committed locally on `main`. **Still not pushed** — same pre-existing
  ~220-commits-ahead-of-origin situation; push still needs explicit confirmation from the
  repo owner.
- Next step: #1-#5 (all the MCIP-shape-into-packet schema work) are done. Pick up #6 (MCIP
  importer, packet enrichment workflow, 190-packet backfill) next — this is the first issue
  that's genuinely different in kind from #2-#5: it needs an actual importer tool
  (`tools/import_mcip.py`?) that reads an MCIP bundle (schema/mcip/v1/, from #1) and folds
  it into a packet's own child records (proof_variants, dependency_manifest, attempts/
  negative_examples/repair_trajectories, model_runs — all from #2-#5), with dry-run,
  validation, conflict detection, and resumable batch operation, plus a backfill status
  report for the corpus's existing packets and a machine-readable loss report for
  unrecoverable fields. This is a bigger, more open-ended build than #2-#5 — read the full
  issue body again before starting (`gh issue view 6 --repo Mnehmos/mathcorpus`) rather than
  relying on this summary. #7 (literature-lineage) needs new schemas beyond MCIP's original
  10 record types before #8 (publication policy) can start; consider doing #7/#8 before #6
  if #6 turns out to need more design time than a single /loop iteration comfortably covers
  — split it into child issues per LOOP.md's completion rule rather than silently
  broadening a partial patch.
