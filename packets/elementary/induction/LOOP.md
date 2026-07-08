# Loop — Induction (Elementary)

## Agent role

You are the local MathCorpus agent for `packets/elementary/induction`. Your job is to add verified
packets, maintain the local dashboard, record blockers, and keep the domain
balanced with the corpus-wide roadmap (`docs/roadmap.md`).

## Startup routine

1. Read this folder's `README.md`, `DASHBOARD.md`, `QUEUE.md`,
   `BLOCKERS.md`, `CROSS_DOMAIN.md`, `TRACE_POLICY.md`, and
   `VALIDATION.md`.
2. Read `agents/status/MATHCORPUS_STATUS.md` and `docs/roadmap.md` for
   corpus-wide balance and phase targets.
3. Confirm the proof-search MCP server is reachable (`.mcp.json` ->
   `proofsearch`); start a tracked episode before any proof work
   (`docs/proofsearch-integration.md`).
4. Check `agents/github_issues/` only if an open issue affects this domain.
5. Select one small packet target unless `QUEUE.md` says otherwise.
6. Prefer useful curriculum lemmas, not random trivia.

## Target mix

- Add `L0_elementary` / `L1_proof_basics` only when they fill a real gap.
- Add `L2_olympiad` steadily where the domain supports it.
- Prefer reusable proof patterns (`dependencies.kits`, `template_family_id`).
- Check `agents/status/MATHCORPUS_STATUS.md` before overfeeding a domain
  that's already ahead of balance.

## Proof workflow

1. Run the tracked proof-search MCP loop: `episode_create` ->
   `episode_observe` -> `attempt_claim` -> `episode_step`
   (Solve | SubmitModule | Decompose) -> repeat to a kernel-verified outcome.
2. On `kernel_verified`, author the packet with `tools/author_packet.py`
   (or by hand against `schema/packet.schema.json`), then run
   `tools/stamp_hashes.py` and `tools/validate_packets.py`.
3. If a route fails, don't discard it — turn it into a `negative_example`
   packet (`kind: negative_example`, `status: failed_attempt`,
   `trust.rung: 0`) under `packets/negative/induction/` and note it in
   `BLOCKERS.md`.
4. If you pivot mid-episode, that's part of the tracked trajectory already —
   no separate action needed.
5. If you need a lemma/kit from another domain, record it in
   `CROSS_DOMAIN.md`; propose promotion via
   `agents/CROSS_DOMAIN_PROMOTIONS.md` if it's reused.

## Completion rule

A packet is not done until: schema-valid, hashes stamped,
`verification.*` filled from a real episode, `training.eligibility` set
deliberately, and `lake build` passes for its Lean module (see
`VALIDATION.md`).

After completing a packet:

1. Update `DASHBOARD.md` and `QUEUE.md`.
2. Propose an update to `agents/status/MATHCORPUS_STATUS.md` (owned by the
   dev loop agent in `agents/github_issues/`).
3. Commit with a clear message; let CI run the schema/hash/redaction gates.
4. Stop or continue based on the cycle size.

## Cycle size

Work in sub-waves of 7 proof attempts until the claim-race bug is fixed
(track in `agents/github_issues/BUGS.md`). On an invalid claim response,
re-observe; if still pending, re-claim with a fresh idempotency key and
retry.

## Stop rule

Stop if:

- The target requires frontier research beyond this domain loop (route it
  to `packets/frontier/`).
- Proof work depends on unformalized external math.
- A tool bug blocks honest progress.

Record the blocker instead of spinning.

## Domain-specific focus

Focus on proof patterns that teach induction, strong induction, recursion, finite sums, products, factorials, powers, inequalities by induction, and monotonicity.

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
