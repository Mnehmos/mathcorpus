# Proof-search integration

MathCorpus formal artifacts are produced by a **verifier-backed proof-search loop**, not
by pasting proofs. This is what makes the corpus trustworthy *and* what generates the
richest training signal: every failed attempt, Lean diagnostic, and repair step is
preserved, not just the final winning proof.

## Trust boundary

- **Evidence:** tracked proof-search actions and **Lean kernel verdicts**.
- **Not evidence:** a model's hidden reasoning, a prior session's transcript, a paper's
  claim, or a proof checked some *other* way. Those are *candidates* until the pinned
  Lean kernel checks them inside a tracked episode.

A packet may only be marked `kernel_verified` / `verified_certificate` on the basis of an
outcome the environment actually recorded (`kernel_verified` or `certified`). This is the
same principle as the corpus's core rule: **proof authority comes only from checked
artifacts.**

## The loop (per obligation)

```
problem_create
  -> problem_submit_fidelity_review   (or unsafe_dev_attestation for dev/benchmark)
  -> episode_create
  -> episode_observe                  (read current obligation + action_request)
  -> attempt_claim                    (get action_attempt_id + claim_token)
  -> episode_step(action, ...)        (Solve | SubmitModule | Decompose)
  -> repeat until the episode outcome is set
```

- **Solve** — a single self-contained tactic/term proof of the current obligation.
- **SubmitModule** — helper defs/theorems, structural/well-founded/mutual recursion.
- **Decompose** — split an over-large obligation into child sub-lemma obligations.

Every candidate attempt goes through `episode_step` — never a side channel — so the run
counts as valid evidence and the failed attempts survive as data.

## From episode → packet

When an obligation reaches `kernel_verified` (or a certificate reaches `certified`):

1. Extract the theorem name, pretty-printed statement, imports, and pinned toolchain into
   the packet's formal fields.
2. Set `trust.rung` / `trust.proof_authority` by the **mechanism** the ledger recorded
   (kernel proof → rung 1; verified LRAT replay → rung 2; kernel-rechecked witness →
   rung 3; see [`../REDACTION_POLICY.md`](../REDACTION_POLICY.md#trust-ladder)).
3. For certificate-backed claims, record `certificate_sha256` **and**
   `canonical_cnf_sha256`, the DIMACS serializer version, and — only if a Lean
   encoding-soundness lemma is proved — set `math_fact_status: proved`. Otherwise the
   packet is `formula_fact_only`.
4. Failed/abandoned attempts and their diagnostics become **negative-example** packets
   (`kind: negative_example`, `status: failed_attempt`, `trust.rung: 0`) — labeled,
   non-proof-bearing training data. See the geometry `nlinarith` sample.
5. Run `tools/stamp_hashes.py` then `tools/validate_packets.py`.

## Benchmark mode

A frozen benchmark run (e.g. PutnamBench) is a different mode. Public reports of benchmark
results follow a redaction policy: a public summary must **not** contain completed proof
source by default — only aggregate status, hashes, and replay information. This mirrors
MathCorpus's quarantine-by-default rule for tracked benchmarks
(see [`../EXPORT_POLICY.md`](../EXPORT_POLICY.md)).

## Tactic-transport hazards (carried into packet authoring)

- Parenthesize inline `by` blocks that are followed by more tactics in a flattened
  sequence: `have h : T := (by omega); ...`.
- Prefer one location per `simp`/`norm_num` in fragile/generated proofs.
- `nlinarith` over raw Euclidean angle atoms is a deterministic budget-burner — bridge
  geometry into scalar equations first. (This hazard is itself captured as a negative
  example.)
