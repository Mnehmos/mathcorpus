# Contributing to MathCorpus

MathCorpus is a **verifier-gated dataset product**. A contribution is not "a proof" — it
is a **concept packet**: a formal artifact plus the provenance, trust, hash, redaction,
and training metadata that make it safe to publish and useful to train on.

## The contribution unit: a concept packet

Each packet is one JSON file under `packets/<domain-path>/<name>.<version>.json`,
conforming to [`schema/packet.schema.json`](schema/packet.schema.json). Formal packets
reference a Lean proof under `lean/` via `lean_module` / `proof_body_path`.

## Workflow

1. **Author or search for the proof.** Formal artifacts must enter through the tracked
   proof-search loop so failed attempts and diagnostics are preserved
   (see [`docs/proofsearch-integration.md`](docs/proofsearch-integration.md)). A proof is
   a *candidate* until the pinned Lean kernel checks it in a tracked episode.
2. **Write the packet JSON.** Fill provenance, trust, training, and (if applicable)
   certificate + encoding-soundness objects. See existing packets under `packets/` as
   templates.
3. **Stamp hashes.** `python tools/stamp_hashes.py packets/<path>.json`
4. **Validate.** `python tools/validate_packets.py packets/<path>.json`
5. **Open a PR.** CI must be green (see gates below).

## PR gates (CI, on any change to `packets/`, `schema/`, or `tools/`)

- schema validation;
- hash regeneration diff check (`stamp_hashes.py --check`);
- redaction audit (no restricted artifact leaks into a public export);
- dedupe-cluster consistency;
- split-manifest invariants (template-locked splits);
- `lake build` for affected formal packets (when the Lean toolchain is available in CI);
- certificate metadata integrity for certificate-bearing packets.

## Third-party content rules (conservative)

- **Allowed by default:** project-authored Lean code and prose; permissively licensed
  imported Lean code **with attribution**; CC BY / CC0 prose **with attribution**.
- **Allowed only after review:** MIT/BSD-style imported formal code if provenance is
  precise; benchmark statements if rights and contamination policy are clear.
- **Disallowed for public export unless explicit permission exists:** verbatim textbook
  prose, competition solution writeups, private correspondence, benchmark proof bodies
  under redaction, third-party notes with unclear license.

Where possible, **restate mathematics in project-authored prose and cite the source**
rather than copy source text.

## Trust & encoding discipline

- Set `trust.rung` / `trust.proof_authority` by the *mechanism* that produced the proof
  (see [`REDACTION_POLICY.md`](REDACTION_POLICY.md#trust-ladder)), not by the result.
- For certificate-backed claims, you **must** record both `certificate_sha256` and
  `canonical_cnf_sha256`. A certificate hash without the canonical CNF hash is rejected.
- If `encoding_required` is true and the encoding-soundness lemma is not proved, the
  packet is `formula_fact_only` — it may not claim a kernel-verified *mathematical*
  theorem.

## Licensing of contributions

By contributing you agree your code/formal assets are licensed Apache-2.0 and your prose
under CC BY 4.0 (see [`LICENSE`](LICENSE) / [`CONTENT_LICENSE`](CONTENT_LICENSE)), unless
the packet's `source_provenance` records a different upstream license.
