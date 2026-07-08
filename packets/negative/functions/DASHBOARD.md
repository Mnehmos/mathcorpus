# Dashboard — Functions (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 3 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

Packets:

- `surjective_implies_injective_finite_pigeonhole_misapplied.v1.json` —
  first `false_generalization`-category example for this domain: the
  finite pigeonhole fact (surjective implies injective between equal-size
  finite sets) does not generalize to ℕ; `simp [Function.Injective]`
  correctly leaves the goal unsolved on `∀ f : ℕ → ℕ, Surjective f →
  Injective f`. Tracked episode `a1bfdf14-1b81-4ab9-8765-58837d5a0df4`;
  falseness separately kernel-verified via witness `f n = n - 1` in the
  companion positive packet
  `elementary.functions.surjective_not_always_injective.v1` (episode
  `0b3fa2fb-5c8c-4295-8fd2-317131e38400`). Resolves the domain's queued
  "false converse" candidate (simplified from the Finset-backed finite-
  type phrasing to a direct ℕ-domain statement, same lesson).
- `injective_add_decide_failure.v1.json` — `decide` fails to elaborate on
  `Function.Injective (fun n : ℕ => n + 5)` (no `Decidable` instance for a
  `∀`-goal over an infinite domain). Tracked via proofsearch episode
  `2874844f-84d1-476e-92b9-5cfe043a88cf` (step 1: `decide` -> kernel_fail;
  step 2: `give_up`).
- `quad_injective_simp_unfold_incomplete.v1.json` — `simp
  [Function.Injective]` unfolds the definition of `Function.Injective (fun
  n : ℕ => n ^ 2 + n)` but leaves the resulting quadratic implication
  unsolved (no case-split lemma in simp's default set). Tracked via
  proofsearch episode `6ae6dffb-77c7-4873-9d7a-be0dd4bf03b8` (step 1
  `simp [Function.Injective]` -> kernel_fail/unsolved_goals, step 2
  `give_up`). A companion attempt at the *linear* version of this lesson
  (`fun n : ℕ => 3 * n + 7`) turned out to kernel_verify outright with the
  same bare tactic — authored as the positive packet
  `elementary.functions.linear_injective_concrete_instance.v1` instead (episode
  `9c3f7163-1f67-476e-805c-ca041ca93bfe`).

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
