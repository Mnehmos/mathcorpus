# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-11
- Issue worked: #3 (dependency manifests) — done, see `DONE.md`. #1 and #2 done earlier the
  same session, prior entries.
- State left in: everything from #1/#2, plus `packet.schema.json`
  (`dependency_manifest` + `$defs.dependency_manifest`/`dependency_claim_source`),
  `tools/mathcorpus/policy.py` (`check_dependency_manifest`,
  `check_dependency_manifest_refs`), `tools/build_manifests.py`
  (`dependency_manifest_summary` in `dependency_graph.json`), `tools/author_packet.py`
  (fixed dropped `theorem_deps`, added `dependency_manifest` spec support), 5 migrated
  algebra packets (now carrying both `proof_variants` and `dependency_manifest`),
  `ENUMS.md` + `CONTRIBUTING.md` docs. Committed locally on `main`. **Still not pushed** —
  same pre-existing ~220-commits-ahead-of-origin situation; push still needs explicit
  confirmation from the repo owner.
- Next step: pick up #4 (negative-example / repair-trajectory child records) next — same
  embed-MCIP-shape-into-packet pattern as #2/#3 (MCIP's `AttemptRecord`/`NegativeExample`/
  `RepairTrajectory` schemas from #1 already exist; embed into `packet.schema.json`, add
  policy checks, migrate/author fixtures — note the existing top-level `failure` object on
  packets is the shallow predecessor this extends, analogous to how `dependency_manifest`
  extended `dependencies`). Then #5 (empirical difficulty), same pattern. #6 (importer) is
  blocked on more of #4-#5 landing to be worth building. #7 (literature-lineage) needs new
  schemas beyond MCIP's original 10 record types before #8 (publication policy) can start.
