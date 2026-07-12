# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-11
- Issue worked: #2 (proof profiles / restriction profiles / proof variants) — done, see
  `DONE.md`. #1 (MCIP v1 schema foundation) done in the same session, prior entry.
- State left in: everything from #1, plus `packet.schema.json` (`proof_variants` +
  `$defs.proof_variant`/`proof_profile`), `restriction_profiles/no_ring_automation.v1.json`,
  `tools/stamp_restriction_profiles.py`, `tools/mathcorpus/policy.py`
  (`check_proof_variants`, `check_restriction_profile_refs`), `tools/mathcorpus/mcip.py`
  (registry helpers factored out of `validate_mcip.py`), `tools/validate_packets.py` (now
  also validates `restriction_profiles/`), 5 migrated algebra packets, `ENUMS.md` +
  `CONTRIBUTING.md` docs. Committed locally on `main`. **Still not pushed** — same
  pre-existing ~220-commits-ahead-of-origin situation from the #1 handoff; push still needs
  explicit confirmation from the repo owner.
- Next step: pick up #3 (dependency manifests) next — same pattern as #2 (embed the MCIP
  `dependency_manifest` shape into `packet.schema.json`, wire `author_packet.py`, add
  policy checks, migrate fixtures). Then #4 (negative-example/repair-trajectory) and #5
  (empirical difficulty), which follow the same embed-MCIP-shape-into-packet pattern. #6
  (importer) is blocked on more of #3-#5 landing to be worth building. #7
  (literature-lineage) needs new schemas beyond MCIP's original 10 record types before #8
  (publication policy) can start.
