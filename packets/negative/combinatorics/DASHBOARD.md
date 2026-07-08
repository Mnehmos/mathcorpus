# Dashboard — Combinatorics (Negative Examples)

| Metric | Value |
|--------|-------|
| Packets | 2 |
| Level breakdown | n/a — negative examples are not leveled the same way; see `trust.rung: 0` |

- `finset_card_atoms_omega_failure.v1.json` — `omega` applied directly to raw
  `Finset.card` atoms (union/intersection identity) without bridging through
  `Finset.card_union_add_card_inter` first; produced via a real tracked
  episode (`29b897d0-2c51-4a9b-8bb4-5f781b0a753c`) that reached `gave_up`
  after a genuine `omega` kernel_fail.
- `card_union_no_disjoint_false_generalization.v1.json` — first
  `false_generalization`-category example for this domain: `simp` fails
  (no progress) on the unconditional claim `∀ s t : Finset ℕ, (s ∪ t).card
  = s.card + t.card`, which is genuinely false without a `Disjoint s t`
  hypothesis. Produced via tracked episode
  `2e76ae52-d1eb-49e5-be37-230bb2ffad61`; the falseness is separately
  kernel-verified (not just inferred from the failed attempt) by the
  companion positive packet
  `packets/elementary/combinatorics/card_union_not_additive.v1.json`
  (episode `f2bb04ed-af84-4d4c-a1ac-c1f953ffea51`, `kernel_verified`, via
  witness `s = t = {0}`).

Last synced: 2026-07-08 — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets.

Next targets: see `QUEUE.md`.
