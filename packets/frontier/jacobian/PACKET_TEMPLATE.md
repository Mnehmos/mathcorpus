# Packet Template — Jacobian Conjecture Frontier

Each packet is a **single JSON file** conforming to
[`schema/packet.schema.json`](../../../schema/packet.schema.json) — not a folder.
See [`schema/ENUMS.md`](../../../schema/ENUMS.md) for the controlled vocabulary
and [`CONTRIBUTING.md`](../../../CONTRIBUTING.md) for the authoring workflow.

- File: `packets/frontier/jacobian/<name>.v<version>.json`
- Paired Lean proof: `lean/MathCorpus/Frontier/Jacobian/<Name>.lean`, referenced
  by `lean_module` / `proof_body_path`.
- Generate with `tools/author_packet.py`, passing `verifier_export_bundle` (the
  MCIP bundle from the sibling repo's `mathcorpus_export`) so `proof_variants`,
  `dependency_manifest`, `attempts`, `negative_examples`, and the #263
  `literature_source` / `idea_attribution` provenance fold in from the tracked
  ledger instead of being hand-copied.

A complete packet answers, via its schema fields:

1. What is the theorem? — `informal_statement`, `formal_statement_pp`
2. Domain/level/difficulty — `domain: frontier`, `level: L7_frontier`,
   `difficulty_bin`
3. What was proved? — `theorem_name`, `proof_body_path`, `verification.outcome`
4. What was NOT proved? — `notes` (dim-2 open; geometry/stabilization/bridges
   open or conditional)
5. Source/attribution — `source_provenance` + the folded-in `idea_attributions`
   (Mathew posed, Alpöge/Fable constructed, Chojecki/ulam.ai wrote up)
6. Proof method — `informal_proof_idea`, `dependencies.tactic_tags`
7. What failed first? — the linked `negative_example` records / `attempts`
8. What verifies it? — `verification.episode_id`, `verification.outcome`,
   `verification.fidelity_status`, `trust.proof_authority: lean_kernel`
9. Export policy — `training.eligibility: quarantined` (peer review ongoing)
10. Trust class — `trust.rung: 1`, `trust.public_claim_class`

## Trust / provenance specifics for this lane

- `verification.verifier`: `proofsearch`;
  `verification.environment_hash`: `9e26d28e…` (the release environment);
  `verification.fidelity_status`: `verified` for rows 2–6, else `attested`.
- `trust.rung`: 1 (Lean kernel); `trust.proof_authority`: `lean_kernel`.
- The `literature_source` / `idea_attribution` records carry
  `visibility: model_visible` (the ulam.ai paper was in the proof-search
  model's run context) and `attribution_status: directly_used` for the map,
  determinant, and collision computations. These are **evidence, never proof
  authority** — they have no proof-status field.

## Anti-overclaim note (MANDATORY)

Every packet in this lane must explicitly state in `notes` that it certifies
only the counterexample's defining computations and their consequence for the
formalized conjecture in the stated dimension — and that the dimension-2
problem, the fiber/image geometry, general-n stabilization, and the
Dixmier/Mathieu/Zhao/cubic-reduction bridges are open or only conditionally
proved, never resolved here.

## Global Operating Rule

Do not let proof work escape the proof environment. If it proves the theorem,
verify it through the Lean kernel inside a tracked episode. Provenance rides
along as MCIP evidence, never as proof authority. The Lean kernel decides. The
ledger records.
