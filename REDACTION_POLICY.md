# Redaction Policy

MathCorpus is **fail-closed**. If eligibility for public release is uncertain, the item
is quarantined and only public-safe metadata may be exported.

## Trust ladder

Proof authority is assigned by *mechanism*, not by claimed result. This taxonomy is
enforced by `tools/validate_packets.py` (`trust` object) and mirrors Lean's own
certificate path (`bv_decide` sends the goal to a SAT solver **and verifies the LRAT
proof**; `bv_check` verifies a stored LRAT file; the LRAT checker states its own
soundness theorem — a raw solver verdict without replay is categorically different).

| Rung | Mechanism | `proof_authority` | Exportable as theorem proof? | Training default |
|------|-----------|-------------------|------------------------------|------------------|
| 1 | Lean kernel `decide` / direct kernel proof | `lean_kernel` | yes | public-eligible |
| 2 | `bv_decide` / equivalent verified LRAT replay | `lean_verified_lrat` | yes, if encoding satisfied | public-eligible with care |
| 3 | Imported SAT model + kernel re-evaluation | `kernel_rechecked_witness` | yes, if encoding satisfied | public-eligible with care |
| 4 | General LRAT import for canonical CNF | `lean_verified_lrat` | yes, if encoding satisfied | public-eligible with care |
| 5 | External solver verdict, nothing checked in Lean | `none` | **no** | never proof-bearing; internal/empirical only |

Rung 0 (`proof_authority: none`, `status: failed_attempt`) is reserved for labeled
**negative examples** — valuable training data that never bears a proof claim.

## Encoding-soundness rule (the most important gate)

> A checked certificate proves a property of a **formula**. A **mathematical theorem** is
> claimable only when the theorem is stated directly over the encoded object, **or** an
> explicit Lean encoding-soundness theorem links the formula fact to the mathematical
> statement.

**Hard rule (enforced):** if `encoding_required = true` and
`encoding_soundness_status != proved`, then `math_fact_status` **must** be
`formula_fact_only`, and the packet **may not** carry `kernel_verified` /
`verified_certificate` as a *mathematical* theorem export. This prevents smuggling
combinatorial search results into publicly claimed theorems without a proved encoding
lemma.

## Redaction gates

If an item belongs to a tracked benchmark or open-problem campaign and public proof
release is restricted, then **all** of the following are treated as *proof-body
artifacts* and are withheld from public export:

- Lean proof bodies
- solver models
- LRAT / DRAT files
- CNF encodings of the exact benchmark statement
- private audit traces

**Public exports MAY include** (public-safe metadata): `packet_id`, title, trust rung,
certificate type, certificate checker, certificate hash, canonical CNF hash, encoding
lemma name, toolchain + mathlib revision, public status and review label.

**Public exports MUST NOT include:** the restricted proof body, the certificate file, a
solver model, a benchmark-specific CNF encoding of the target statement, or private audit
traces.

## Quarantine defaults

The following default to `quarantined` or `private_audit_only`:

- tracked benchmark proof bodies;
- benchmark-specific certificates, solver models, and CNF encodings;
- open-problem campaign proof artifacts pending external review;
- third-party source text with uncertain license compatibility;
- self-reviewed frontier proofs whose public claim would attract strong scrutiny;
- negative examples exposing private prompts, internal traces, or non-public benchmark routes;
- schema-conformance fixtures whose content is illustrative rather than real corpus data
  or real telemetry (`kind: concept`, `training.eligibility: private_audit_only` — the
  convention used by `packets/negative/_fixtures/` and `packets/_fixtures/`). Never
  `negative_example_only`, which would place synthetic content in the real
  `negative_examples.jsonl` training surface.

## Literature-lineage and publication policy independence

`idea_attributions`, `prior_art_matches`, `citation_reviews`, `contribution_statements`,
and `publication` (`schema/mcip/v1/`, see [`DATASET_CARD.md`](DATASET_CARD.md)) are a
separate review dimension from the trust ladder above and **never** change `trust.rung`,
`proof_authority`, or `status` — citation or novelty uncertainty affects only public claim
status. `publication.status: "publication_ready"` additionally requires a current,
non-superseded, endorsed `citation_review` for any `open_problem_related` packet or any
`contribution_class: "new_proof"` claim; kernel verification alone can never produce it.

A `RetrievedPassage` follows the same redaction shape as a proof body: `passage_redacted`
+ nullable `passage_text`, with `passage_sha256` always retained so a public export can
prove what was cited without reproducing the excerpt.
