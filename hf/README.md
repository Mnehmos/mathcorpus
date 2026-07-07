---
license: apache-2.0
license_name: mathcorpus-mixed
license_link: https://github.com/Mnehmos/mathcorpus/blob/main/NOTICE
pretty_name: MathCorpus
language:
  - en
tags:
  - lean4
  - mathlib
  - theorem-proving
  - formal-mathematics
  - verifier-gated
  - curriculum
task_categories:
  - text-generation
configs:
  - config_name: default
    data_files:
      - split: train
        path: train.jsonl
      - split: val
        path: val.jsonl
      - split: test_public
        path: test_public.jsonl
      - split: heldout_public
        path: heldout_public.jsonl
---

# MathCorpus (Hugging Face mirror)

A verifier-gated, provenance-complete, curriculum-shaped mathematics corpus for training
theorem-proving agents. Every accepted proof is kernel-checked or certificate-checked;
every item is hash-pinned and attributed; every export is governed by explicit trust and
redaction policy.

> **This Hub repo is a mirror, not the trust layer.** Redaction is applied upstream in the
> [GitHub source repo](https://github.com/Mnehmos/mathcorpus); this mirror distributes only
> the already-redacted public export. Canonical governance, schema, and tooling live there.

## Licensing (mixed)

- Lean sources, tactics, formal proofs, tooling → **Apache-2.0**
- Prose, informal statements, proof ideas, cards → **CC BY 4.0**
- Internal / restricted proof artifacts → **not distributed**

See `NOTICE`, `LICENSE`, and `CONTENT_LICENSE` in the source repo. Per-item provenance is
in each row's `source_provenance`.

## Splits

`train`, `val`, `test_public`, `heldout_public` are published here. `heldout_private`,
`quarantined`, and `private_audit_only` are **not** distributed. Negative examples ship in
`negative_examples.jsonl`.

## Responsible use

Tracked-benchmark and open-problem artifacts default to quarantine (fail-closed); proof
bodies are redacted from public export. Proof authority derives only from checked
artifacts; certificate "formula facts" are separated from "mathematical facts" unless a
proved encoding-soundness lemma links them. Removal requests: see the source repo's
`TAKEDOWN_POLICY.md`; tombstones are published in `governance/REMOVALS.jsonl`.

## Citation

```bibtex
@misc{mathcorpus,
  title  = {MathCorpus: A Verifier-Gated Mathematics Training Corpus},
  author = {The MathCorpus Authors},
  year   = {2026},
  note   = {https://github.com/Mnehmos/mathcorpus}
}
```
