# Evaluation suite

Evaluation is built around **verified end states**, not text similarity — following Lean's
role as a proof assistant and Formal Conjectures' use of standardized, frozen subsets.

## Task families

| Task | Input | Output | Primary metric |
|------|-------|--------|----------------|
| Informal→formal | natural statement | Lean theorem statement | elaboration success, exact / α-normalized match |
| Formal-proof synthesis | theorem statement | Lean proof | kernel-verified success, pass@k |
| Next-tactic prediction | proof state | tactic | exact / top-k match, downstream closure |
| Proof repair | broken proof | repaired proof | build success, minimal edit distance |
| Proof explanation | Lean proof/theorem | prose explanation | human eval; optional rubric |
| Dependency retrieval | theorem statement | prerequisite lemmas/kits | recall@k, proof success after retrieval |
| Certificate reconstruction | encoded CNF / packet | theorem + checked metadata | verified replay success |
| Negative-example discrimination | attempt trace | gap category + corrective route | classification accuracy; downstream improvement |

## Global metrics

kernel success rate · pass@1 / pass@k · wall-clock to verified proof · proof length &
tactic count · certificate replay time · artifact-complete rate (rows with full
provenance/trust fields) · contamination-clean rate · split leakage incidents · repair
success on curated failures.

## Difficulty bins (packet-native, `difficulty_bin`)

`D0` exact rewrite/automation · `D1` short human proof · `D2` retrieval/nontrivial tactics
· `D3` structured multi-lemma · `D4` certificate-backed / known theorem · `D5`
frontier/quarantined only.

## Heldout & leaderboard rules

1. All evaluations run under a **pinned** Lean + mathlib toolchain.
2. A submission succeeds only if its artifact passes the same `lake build` / kernel-check
   path as the corpus release.
3. The public leaderboard uses only `test_public` and `heldout_public`.
4. `heldout_private` is used for periodic blind evaluation.
5. Entrants disclose: training data used; whether MathCorpus train/val was used;
   contamination-screening method; model version; prompting/search policy; max attempts
   and compute budget.
6. Proofs relying on quarantined benchmark proof bodies are **invalid** for public
   leaderboard submission.

_Runner scripts and frozen eval packs land in Phase 7._
