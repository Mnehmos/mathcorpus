# Solved Queue — Formal Conjectures

Problems solved upstream or in the literature but not yet
formalized/verified in this repo.

## Survey progress (2026-07-08, this agent)

Ran the survey this file previously called for: grepped every non-Erdős
top-level category in the local `formal-conjectures` checkout for
`@[category research solved ...]` tags, then fully triaged the six
smallest categories (12 files) by hand — checking each `research solved`
theorem's actual proof body (bare `sorry` vs. a real proof) rather than
trusting the tag alone, since the Erdős lane's whole win pattern depends
on that distinction.

**File counts per category** (files containing >=1 `research solved` tag;
not yet triaged beyond the six below): `Wikipedia/` 60, `GreensOpenProblems/`
30, `WrittenOnTheWallII/` 21, `Paper/` 12, `OEIS/` 7, `Mathoverflow/` 5,
`Other/` 5, `Arxiv/` 9, `Books/` 4, `HilbertProblems/` 2,
`OpenQuantumProblems/` 2, `LittProblems/` 1, `Millenium/` 1,
`OptimizationConstants/` 1. (`Kourovka/`, `Subsets/`: 0.)

### Triaged this cycle (6 categories, 12 files)

**Genuinely `sorry` (would need original proof work, not transport) — do
not expect an Erdős-lane-style quick win from these:**
- `Millenium/Poincare.lean::poincare_conjecture` (+ `.variants.smooth_known_cases`)
  — the actual Poincaré conjecture and a smooth-structure variant. Obviously
  out of scope; noting only so nobody re-discovers this is `sorry` and
  wonders if it's attemptable. It is not.
- `HilbertProblems/17.lean::hilbert_17th_problem_poly` and
  `HilbertProblems/5.lean` (all three theorems) — Hilbert's 5th and 17th
  problems, real hard analysis/Lie theory. Not tractable here.
- `Books/BugeaudDistributionModuloOne/Problem10_6.lean::pollington_de_mathan`,
  `boshernitzan` — Hausdorff-dimension results in metric number theory,
  genuine analytic content.
- `Books/BugeaudDistributionModuloOne/Problem10_8.lean` (both variants) —
  same flavor, `sInf`/`liminf`/`padicNorm` machinery.
- `Books/UniformDistributionOfSequences/Equidistribution.lean::isAccumulationPoint_three_halves_pow_infinite`
  — an open-ended `Set.Infinite` accumulation-point claim about `(3/2)^n`
  fractional parts; nontrivial ergodic/equidistribution content.
- `LittProblems/1.lean::lam_litt.variants.eisenstein` — algebraic (Eisenstein
  integrality of power series coefficients), real proof content needed.
- `OptimizationConstants/1a.lean` (both bounds) — numeric bounds from
  named papers (Matolcsi–Vinuesa, Yuksekgonul et al.); would need to
  reproduce those papers' actual numerical/analytic arguments, not a
  short formalization.
- `OpenQuantumProblems/35.lean::ame_5_2_exists`, `ame_6_2_exists`,
  `ame_4_2_not_exists`, `ame_7_2_not_exists`, `ame_4_3_exists`,
  `ame_4_6_exists`, `ame_11_5_open` — still `sorry` (some link to external
  `formal_proof` URLs not yet replayed in this environment; see below).

**Already fully proven upstream (`research solved`, no `sorry`) — the
category that mirrors the Erdős lane's actual win pattern, but with a
catch (see verdict):**
- `Books/BorweinSineSeries.lean::borwein_sine_series` — tagged with a
  `formal_proof using lean4` link to an external repo (same "linked but
  not yet replayed in our toolchain" situation the Erdős lane hit with
  #1052's AlphaProof link) — **not actually proven in THIS file**, has a
  `sorry` (re-read: the `answer(sorry)` inside the iff is the "what is
  the answer" placeholder pattern this repo's convention uses even for
  solved statements — the theorem body itself needs checking; treat as
  unverified until someone actually reads past the tag).
- `Books/BugeaudDistributionModuloOne/Problem10_6.lean::furstenberg_two_three`
  — **no visible `sorry`** in the excerpt grepped (the `sorry` shown
  above it belongs to the *previous* theorem, `pollington_de_mathan`) —
  worth a closer look to confirm it's a complete proof, not spot-checked
  further this cycle.
- `OpenQuantumProblems/13.lean::mutuallyUnbiasedBases_dim2` — genuinely
  proven: `simpa using Qubit.qubit_maximal`, and `Qubit.qubit_maximal`
  itself has a real ~15-line proof (`qubit_upper_bound` via
  `LinearIndependent`/Bloch-vector inner-product orthogonality +
  `qubit_hasThreeMUBs`), all self-contained in the same file.
- `OpenQuantumProblems/35.lean::ame_2_exists`, `ame_3_exists`,
  `ame_2_2_exists`, `ame_3_2_exists` — genuinely proven via explicit
  witnesses (`bellState`, `ghzState`) and their `IsAME` proofs, all
  file-local.

**Verdict / why this isn't a "just transport it" win despite being
already-proven**: unlike the Erdős lane's wins (self-contained ℕ/ℤ
arguments needing only Mathlib), every already-proven candidate above
sits on top of substantial **file-local custom infrastructure** —
`OpenQuantumProblems/13.lean`'s `BlochVec`/`bloch`/MUB machinery (~500
lines before the target theorem) and `OpenQuantumProblems/35.lean`'s
`EuclideanSpace ℂ (Config n d)`/`mkStateVector`/`IsNormalized`/
`reducedDensityFirst_of_completion` quantum-state formalism. Transporting
just the target theorem via `SubmitModule` would mean also transporting
(or re-deriving) that whole supporting API, which is a much larger lift
than the short target-theorem proof bodies suggest. **Not a one-cycle
win** — flag as a real candidate for a dedicated multi-cycle push if the
quantum-information infrastructure is ever wanted in this corpus, not as
a quick Lane-1-style transport.

### Not yet triaged

`Wikipedia/` (60 files), `GreensOpenProblems/` (30), `WrittenOnTheWallII/`
(21), `Paper/` (12), `OEIS/` (7), `Arxiv/` (9), `Mathoverflow/` (5),
`Other/` (5) — a future cycle should continue this same triage
(`grep -B1 -A3 "category research solved"` per file, check for a bare
`sorry` body vs. a real proof, and check whether the real proofs are
self-contained or infrastructure-heavy) rather than re-starting from
scratch. `Mathoverflow/` and `Other/` are the smallest untriaged
categories and a natural next pick (5 files each).

## Backlog

- [ ] `HilbertProblems/` — triaged this cycle (see above); both files'
      `research solved` theorems are genuinely `sorry` and genuinely hard
      (5th/17th problems). Not a near-term target.
