# Packet Template — Algebra (Negative Examples)

Each packet is a **single JSON file** conforming to
[`schema/packet.schema.json`](../../../schema/packet.schema.json) — not a folder. See
[`schema/ENUMS.md`](../../../schema/ENUMS.md) for the controlled vocabulary and
[`CONTRIBUTING.md`](../../../CONTRIBUTING.md) for the full authoring workflow.

- File: `packets/<level-dir>/<domain>/<name>.v<version>.json`
- Paired Lean proof: `lean/MathCorpus/<Level>/<Domain>/<Name>.lean`, referenced by
  `lean_module` / `proof_body_path`.
- Use `tools/author_packet.py` to generate the packet JSON + Lean file from a compact
  batch spec once a proof is kernel-verified (see its module docstring for the spec
  shape) — this injects the standard rung-1 trust/training scaffolding so you only
  supply what's genuinely per-packet.

A complete packet answers, via its schema fields:

1. What is the theorem? — `informal_statement`, `formal_statement_pp`
2. What domain and level is it? — `domain`, `level`, `difficulty_bin`
3. What was proved? — `theorem_name`, `proof_body_path`, `verification.outcome`
4. What was not proved? — `status` (e.g. `formula_fact_only`, `failed_attempt`), `notes`
5. What source/curriculum role does it serve? — `source_provenance`,
   `dependencies.prerequisite_concepts`
6. What proof method was used? — `informal_proof_idea`, `dependencies.tactic_tags`
7. What failed first? — captured as a linked `negative_example` packet, or in `notes`
8. What Lean result verifies it? — `verification.episode_id`, `verification.outcome`,
   `trust.proof_authority`
9. What export policy applies? — `training.eligibility`, `training.contamination_risk`
10. Can it be used for training? — `training.eligibility`, `trust.public_claim_class`

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
