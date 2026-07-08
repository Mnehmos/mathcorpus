# Dashboard — Functions (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 1 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

Packets:

- `injective_add_decide_failure.v1.json` — `decide` fails to elaborate on
  `Function.Injective (fun n : ℕ => n + 5)` (no `Decidable` instance for a
  `∀`-goal over an infinite domain). Tracked via proofsearch episode
  `2874844f-84d1-476e-92b9-5cfe043a88cf` (step 1: `decide` -> kernel_fail;
  step 2: `give_up`).

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
