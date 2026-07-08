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

### Triaged this cycle, round 2 — `Mathoverflow/` (5 files, this agent, 2026-07-08)

- `10799.lean::mathoverflow_10799` — tagged `research solved` (the
  original Kahn-Kalai "missing lemma" conjecture is **false** without an
  extra hypothesis, counterexample by Shlomo Perles) and links a
  `formal_proof` URL, but the theorem body in this file is still `sorry`
  — same "linked but not replayed here" pattern as `#1052`'s AlphaProof
  link and `Books/BorweinSineSeries.lean`. Also has ~9 supporting `def`s
  (`μ`, `μFamily`, `boundaryCount`, `edgeBoundary`, `IsOptimal`, ...) that
  would need transporting regardless. Not a quick win.
- `235893.lean::mathoverflow_235893` — the actual open question is
  `sorry` (as expected, tagged `research open`); the file's `research
  solved` companion `mathoverflow_260589` (a connected bijection
  `ℝ → ℝ²` whose inverse isn't connected) is ALSO `sorry`. No win here.
- `34145.lean` — the two `research solved` unit-square rectangle-packing
  results (`rectangles_pack_square_133_div_132`,
  `rectangles_pack_square_501_div_500`) are both `sorry`, citing external
  papers' packing constructions (ScienceDirect links) that would need
  original geometric formalization to reproduce. Not a transport target.
- `486451.lean` — both `research solved` semiring/maximal-ideal
  existence results are `sorry`; the second cites a named
  algorithmically-found example (Žužić–Firsching monoid algebra) that
  would need its own construction formalized from scratch.
- `75792.lean::complexity_five_pow` — **genuinely `sorry`-free, a real
  complete proof** (disproves `‖5^n‖ = 5n` at `n=6` via an explicit
  29-`1`s expression for `5^6`), the first non-Erdős candidate found this
  survey that actually matches the Erdős-lane win pattern. **Blocked
  anyway**: it and its dependency chain are built on a custom `inductive
  Reachable` type, which `SubmitModule` cannot transport (no inductive
  item kind) — see `BLOCKERS.md` for the full writeup. The file's other
  `research solved` theorem, `complexity_three_pow` (Selfridge's actual
  `‖3^n‖=3n` proof), is `sorry` regardless.

**Round-2 verdict**: 0/5 `Mathoverflow/` files yield a transportable win
this cycle — one (`complexity_five_pow`) is a genuine complete proof but
hits a new, general blocker class (custom `inductive` types); the rest
are `sorry` needing either external-proof replay or original geometric/
algebraic construction work. Do not re-triage `Mathoverflow/` from
scratch; this round's findings are final for the current file set.

### Not yet triaged

`Wikipedia/` (60 files), `GreensOpenProblems/` (30), `WrittenOnTheWallII/`
(21), `Paper/` (12), `OEIS/` (7), `Arxiv/` (9), `Other/` (5) — a future
cycle should continue this same triage (`grep -B1 -A3 "category research
solved"` per file, check for a bare `sorry` body vs. a real proof, check
whether real proofs are self-contained vs. infrastructure-heavy, AND
(new this round) check whether the proof depends on a custom `inductive`/
`structure` declaration before investing further time — see `BLOCKERS.md`).
`Other/` is now the smallest untriaged category (5 files) and the natural
next pick.

## Backlog

- [ ] `HilbertProblems/` — triaged this cycle (see above); both files'
      `research solved` theorems are genuinely `sorry` and genuinely hard
      (5th/17th problems). Not a near-term target.
- [ ] `Other/` (5 files) — next natural triage pick, untouched.
