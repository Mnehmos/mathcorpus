# Attribution

MathCorpus is authored by **The MathCorpus Authors**. Per-item authorship and upstream
attribution live in each packet's `source_provenance` object (`authors`,
`copyright_holder`, `source_kind`, `source_refs`, `license_spdx`, `license_content`).

## How attribution works here

- **Project-authored content** (default) is attributed to "The MathCorpus Authors" and
  licensed Apache-2.0 (code/formal) + CC BY 4.0 (prose).
- **Adapted / imported content** records the upstream source in `source_refs` and the
  upstream license in `source_provenance`. That upstream license governs that material.
- Where mathematics is restated in project-authored prose and the source is cited
  (rather than copied), the packet is marked `source_kind: adapted_public_source` with a
  citation in `source_refs`.

## Upstream precedents & references

This corpus's design draws on, and is intended to interoperate with, the following
public precedents. It does **not** redistribute their content; these are design and
methodology references.

| Project | Contribution | Reference |
|---------|--------------|-----------|
| Lean 4 / mathlib | Verification substrate; kernel as proof authority | https://lean-lang.org · https://arxiv.org/abs/1910.09336 |
| ProofNet | Paired NL/formal statements + NL proofs | https://arxiv.org/abs/2302.12433 |
| Formal Conjectures | Research-level Lean statements; frozen eval subsets | https://arxiv.org/abs/2605.13171 |
| The Stack | Licensing, dedup, provenance, takedown governance | https://arxiv.org/abs/2211.15533 |
| NIST FIPS 180-4 | SHA-256 as integrity digest | https://csrc.nist.gov/pubs/fips/180-4/upd1/final |
| Lean `Std.Sat.CNF.Dimacs` | Canonical DIMACS serialization for CNF hashing | https://lean-lang.org/doc/api/Std/Sat/CNF/Dimacs.html |

## Third-party imported packets

_None yet._ Imported third-party formal code or prose will be listed here with its
packet IDs, upstream source, and license once any is admitted (see the import rules in
[`CONTRIBUTING.md`](CONTRIBUTING.md)).
