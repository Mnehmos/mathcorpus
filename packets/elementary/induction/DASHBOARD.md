# Dashboard — Induction (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 13+ |
| Level breakdown | L0_elementary: 1 · L1_proof_basics: 12+ |

Last synced: 2026-07-08 — added `two_pow_gt_self` (D0, L0, episode
`5a175c43-1c93-4cf7-a4e9-5038e1961068`), `bernoulli_inequality` (D1, L1,
episode `344364cb-791a-4e8a-9f5e-be0cc95210de`),
`factorial_ge_two_pow` (D1, L1, episode
`538ea8b6-6ad7-4a16-9e9b-bda5364ba942`: `2^n <= (n+1)!`, kernel_verified on
the first attempt), `sum_evens` (D1, L1, episode
`7c564d42-9a98-4780-9d1c-3affd65958d6`: `∑ i ∈ range n, (2*i+2) = n*(n+1)`,
kernel_verified on the first attempt), and `exists_prime_factor` (D1, L1,
episode `ac1ea7d4-4b1a-406e-8c2a-e209d5cd03d5`: every `n >= 2` has a prime
factor, via `Nat.strong_induction_on` — this domain's first genuine
strong-induction packet), `myfactorial_eq_factorial` (D1, L1, episode
`99b8de59-4ed4-4fa8-b0cd-0d966b9ba800`: hand-rolled `myFactorial` via
`Nat.rec` proved equal to `Nat.factorial` — this domain's first packet
using the `SubmitModule` action rather than `Solve`), and
`foldl_cons_eq_reverse_append` (D1, L1, episode
`0ab12a3b-a0fb-4981-b6fe-63628a4f6fb6`: accumulator-passing `foldl` equals
`reverse ++ acc`; originally attempted as a negative example for
"induction without generalizing" but `simp [ih]` closed it anyway, so
authored as a positive packet instead). Other domain-agent
instances are committing to this folder concurrently — re-sync against
`agents/status/MATHCORPUS_STATUS.md` and `python tools/corpus_stats.py`
after adding packets rather than trusting this count exactly.

Next targets: see `QUEUE.md`.
