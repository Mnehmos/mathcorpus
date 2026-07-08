# Import Policy — Formal Conjectures

Rules for importing a statement from the upstream Formal Conjectures
repository into a MathCorpus packet:

1. Record upstream source, file path, commit hash (if available), problem
   name, and statement hash in `SOURCE_MAP.md`.
2. Set `domain: frontier`, `level: L7_frontier`,
   `source_provenance.source_kind: formal_conjectures`.
3. Classify the packet as one of:
   - `open` — no known proof.
   - `solved-unproved-in-this-repo` — solved upstream/elsewhere but not
     yet formalized here.
   - `already-formally-proved-upstream` — a Lean proof already exists
     upstream.
   - `source-review-needed` — provenance or statement fidelity unclear.
4. Do not import a statement without recording its source in
   `SOURCE_MAP.md`.
5. Do not treat every imported statement as training-eligible — see
   `STATEMENT_FIDELITY.md` and set `source_provenance.statement_fidelity`
   honestly (`author_written`, `canonical_statement_hash_match`,
   `problem_fidelity_verified`, `adapted_with_review`, or `unknown`).

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
