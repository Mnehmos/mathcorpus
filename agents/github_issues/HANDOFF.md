# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-12
- Issue worked: #4 (negative-example / repair-trajectory child records) — done, see
  `DONE.md`. #1, #2, #3 done in the prior session (same continuous /loop run), prior
  entries.
- State left in: everything from #1/#2/#3, plus `packet.schema.json`
  (`attempts[]`/`negative_examples[]`/`repair_trajectories[]` + their `$defs`),
  `tools/mathcorpus/hashing.py` (`repair_step_hash`), `tools/mathcorpus/policy.py`
  (`check_attempts_and_repairs`, `check_repair_trajectory_refs`), a real enrichment of
  `packets/negative/number_theory/gcd_dvd_omega_no_gcd_theory.v1.json` (true attempt +
  true cross-packet repair to `elementary.number_theory.gcd_dvd_left.v1`), a new synthetic
  `packets/negative/_fixtures/diagnostic_categories_conformance.v1.json` (parse_failure /
  unknown_declaration / type_mismatch, `private_audit_only` so it never exports), `ENUMS.md`
  docs. Committed locally on `main`. **Still not pushed** — same pre-existing
  ~220-commits-ahead-of-origin situation; push still needs explicit confirmation from the
  repo owner.
- Next step: pick up #5 (multi-model empirical difficulty + native analytics exports) next
  — same embed-MCIP-shape-into-packet pattern (MCIP's `ModelRun`/`EmpiricalDifficultyAggregate`
  schemas from #1 already exist). Watch the acceptance criterion "existing packet difficulty
  is never silently overwritten by observed difficulty" — same shape of constraint as #3's
  deferred blanket-gate issue, handle it the same way (additive field, not a retroactive
  requirement on the ~350 pre-existing packets). Then #6 (importer) becomes worth building
  once #4/#5 give it enough to actually import. #7 (literature-lineage) needs new schemas
  beyond MCIP's original 10 record types before #8 (publication policy) can start.
