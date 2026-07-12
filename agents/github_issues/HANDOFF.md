# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-11
- Issue worked: #1 (MCIP v1 schema foundation) — done, see `DONE.md`.
- State left in: `schema/mcip/v1/*` + `tools/validate_mcip.py` + `tools/gen_mcip_fixtures.py`
  + `tools/mathcorpus/mcip.py` committed locally on `main`. **Not pushed** — this repo's
  `main` was already ~220 commits ahead of `origin/main` before this session (pre-existing,
  unrelated to this work); push needs explicit confirmation from the repo owner before it
  happens, given the size.
- Next step: pick up #2 (proof profiles / restriction profiles / proof variants as packet
  child records) or #3 (dependency manifests) next — both consume the MCIP shapes #1 just
  defined. #6 (importer) is blocked on more of #2-#5 landing to be worth building. #7
  (literature-lineage) needs new schemas beyond MCIP's original 10 record types before #8
  (publication policy) can start.
