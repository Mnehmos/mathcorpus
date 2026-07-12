# Done — Dev Issues

Completed issues, most recent first.

| Date | Issue | Summary | Fix commit |
|------|-------|---------|------------|
| 2026-07-11 | #1 | MCIP v1: 10 record schemas + bundle envelope under `schema/mcip/v1/`, canonicalization/hashing/version-negotiation rules documented in `schema/mcip/v1/README.md`, `tools/validate_mcip.py` (standalone bundle validator, no Proof Search dependency), `tools/gen_mcip_fixtures.py` + 4 conformance fixture bundles (success proof, failed attempt, repair chain, multi-model aggregate — 17 records, all validate clean with `--check-hashes`), CI step added. Fail-closed behavior (unknown fields, tampered hashes, `NegativeExample.proof_authority` const) smoke-tested directly against the validator. | (local, unpushed — see HANDOFF.md) |
