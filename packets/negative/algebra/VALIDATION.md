# Validation — Algebra (Negative Examples)

Before marking a packet complete in this domain, run (from repo root):

```bash
python tools/stamp_hashes.py packets/negative/algebra/<name>.v<version>.json
python tools/validate_packets.py packets/negative/algebra/<name>.v<version>.json --check-hashes --warn-as-error
```

And confirm:

- [ ] The proof was produced through the tracked proof-search MCP loop
      (`episode_create` -> `attempt_claim` -> `episode_step` ->
      kernel-verified outcome), not pasted in from private reasoning. See
      `docs/proofsearch-integration.md`.
- [ ] `trust.rung` / `trust.proof_authority` match the mechanism the
      episode ledger actually recorded, not the desired result.
- [ ] `verification.episode_id` and the trajectory hashes are filled in.
- [ ] Certificate-backed claims record both `certificate_sha256` and
      `canonical_cnf_sha256`.
- [ ] `training.eligibility` / `training.contamination_risk` are set
      deliberately, not left at a default.
- [ ] Failed routes became a `negative_example` packet rather than being
      discarded.
- [ ] `DASHBOARD.md` and `QUEUE.md` in this folder are updated.
- [ ] `lake build` passes for the new/changed Lean module (when buildable
      locally).

CI re-runs schema validation, hash-check, manifest build, and the redaction
audit on every PR touching `packets/`, `schema/`, or `tools/` — this
checklist should make that a formality, not a surprise.

## Global Operating Rule

Do not let proof work escape the proof environment. Per
`docs/proofsearch-integration.md`: evidence is tracked proof-search actions and Lean
kernel verdicts; a model's hidden reasoning, a prior transcript, a paper's claim, or a
proof checked some other way are **candidates**, not evidence, until the pinned Lean
kernel checks them inside a tracked episode.

- If it matters to how the proof was found, record it (attempts, diagnostics, pivots,
  Mathlib lookups, repairs) — the tracked episode trajectory does this automatically.
- If it proves the theorem, verify it through the Lean kernel inside a tracked episode.
- If it fails, keep it — failed/abandoned attempts become `negative_example` packets
  (`kind: negative_example`, `status: failed_attempt`, `trust.rung: 0`), not silently
  discarded reasoning.
- If it uses another domain's lemma/kit, record it in `CROSS_DOMAIN.md`.
- If it becomes reusable across domains, propose promotion — see
  `agents/CROSS_DOMAIN_PROMOTIONS.md`.

Private reasoning is not proof authority. The Lean kernel decides. The ledger records.
