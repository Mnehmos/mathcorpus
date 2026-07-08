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

### Triaged this cycle, round 3 — `Other/` (5 files, this agent, 2026-07-08)

- `BeaverMathOlympiad.lean::beaver_math_olympiad_problem_3`, `_problem_4`
  — both `sorry` (Busy-Beaver-adjacent number-theoretic dynamics over a
  recursive sequence with `padicValNat`). Real, hard, original content.
  Out of scope.
- `SchurTruncatedExponential.lean::schur_truncatedExp_galoisGroup_equiv`
  — `sorry` (Galois group of the truncated exponential's minimal
  polynomial is `A_n`/`S_n` depending on `n mod 4`). Genuine Galois
  theory. Out of scope.
- `SuffixPrefixAvoidance.lean::suffix_prefix_avoidance_bound` (the exact
  isoperimetric bound) and `_weaker_bound` (a `ℚ`-valued corollary with a
  `formal_proof` link to this same upstream file, i.e. still the
  "linked but not replayed here" pattern) — **both `sorry`**. Out of
  scope.
- `VCDimConvex.lean` — the three `research solved` lemmas shown
  (`hasAddVCDimAtMost_three_of_convex_r2`,
  `exists_infinite_convex_r3_shatters`,
  `exists_convex_rn_add_two_vc_n_forall_not_hasAddVCNDimAtMost`) are all
  `sorry`. Genuine VC-dimension/convexity results. Out of scope.
- `EquationalTheories_677_255.lean` — **the round's actual find.** Of its
  three `research solved` theorems, two are genuinely proof-complete, no
  `sorry`: `Equation255_not_implies_Equation677` and
  `Finite.Equation255_not_implies_Equation677` (the third,
  `Equation677_not_implies_Equation255`, is `sorry`). Both proven ones use
  the SAME explicit finite witness — a `Fin 3` magma with operation table
  `![![1,2,0],![2,0,1],![0,1,2]]` — checked by `fin_cases`/`decide`. This
  is from the real, actively-maintained "Equational Theories" project
  (Terence Tao et al., teorth.github.io/equational_theories), a genuinely
  solved literature result, not a conjecture.

  **Naively blocked the same way as `Mathoverflow/75792.lean` last
  round**: the witnesses are instances of a `class Magma (α : Type) where
  op : α → α → α`, and `class`/`structure` declarations are exactly the
  "custom inductive-shaped item" `SubmitModule` cannot transport (see
  `BLOCKERS.md`'s general finding from round 2).

  **But this one has a real workaround, unlike `complexity_five_pow`**:
  `Magma`/`Equation255`/`Equation677` are trivial wrappers — `Equation255
  G := ∀ x, x = ((x◇x)◇x)◇x` and `Equation677 G := ∀ x y, x = y◇(x◇((y◇x)◇y))`
  are plain `abbrev`s over `Magma.op`, not genuine structure the way
  `Reachable`'s inductive proof-term structure was load-bearing for
  `complexity_five_pow`. The class layer here is purely notational sugar
  around a binary function — nothing in the *proof* (`fin_cases <;> rfl`
  / `of_decide_eq_false rfl`) actually depends on `Magma` being a
  typeclass rather than a bare function argument. **The whole result
  restates cleanly with zero custom types**, using only `Fin 3 → Fin 3 →
  Fin 3` and closed-form arithmetic (the table above is exactly
  `op i j = i + j + 1` in `Fin 3`, i.e. `i,j ↦ i+j+1 (mod 3)` — verified
  by hand against all 9 table entries):

  ```
  theorem equation255_not_implies_equation677 :
      ∃ op : Fin 3 → Fin 3 → Fin 3,
        (∀ x : Fin 3, x = op (op (op x x) x) x) ∧
        ¬ (∀ x y : Fin 3, x = op y (op x (op (op y x) y))) := by
    refine ⟨fun i j => i + j + 1, fun x => by fin_cases x <;> decide, ?_⟩
    decide
  ```

  (The `Finite.` variant adds nothing new once the type is already the
  concrete `Fin 3`, so a single un-classed theorem covers both upstream
  results.) This is a **ready-to-attempt candidate for a future cycle**
  (or for whichever concurrent agent instance is doing full companion-
  result packet authoring in this lane, per that folder's own broader
  `LOOP.md` — this agent's standing instructions keep this specific
  survey to dossier-only, not packet authoring). Anti-overclaim note for
  whoever attempts it: this is a **restatement avoiding the class layer**,
  not a verbatim transport of the upstream proof term — say so explicitly
  in `source_provenance`/`notes` (`statement_fidelity` should probably be
  `adapted_with_review`, not a straight match), since the upstream
  `root_statement_hash` machinery would not match a class-free restatement
  even though the mathematical content is identical.

**Round-3 verdict**: 1/5 `Other/` files yields a genuine, tractable,
currently-unblocked candidate (`EquationalTheories_677_255`'s witness,
restated class-free) — the first one this whole survey has found that
isn't stopped by either "still sorry", "infrastructure-heavy", or the
inductive-type `SubmitModule` blocker. The other 4 are real, hard,
out-of-scope original mathematics.

**General lesson for future triage rounds**: when a candidate is blocked
by the `class`/`structure`/`inductive`-item-kind limitation, don't stop
at "blocked" — check whether the class is *load-bearing* for the proof
(as `Reachable`'s inductive constructors were) or *purely notational*
(as `Magma` is here). A notational class over a `Fin n`/finite carrier
can often be restated as a bare function argument with zero mathematical
loss, turning a hard blocker into a two-line rewrite.

### Triaged this cycle, round 4 — `Arxiv/` (14 files, this agent, 2026-07-08)

Corrected the file count: `Arxiv/` actually has 14 files (13 problem
folders, one — `2602.05192/` — with two), not the 9 estimated by the
original grep-for-tag-count survey (that count only found files with
`research solved`; `Arxiv/` also has several `research open`-only files
not counted there). Checked every file with >=1 `research solved` tag
(11 of the 14):

**Result: 0/11 files yield a transportable win. Every single `research
solved` theorem body across the whole category is `sorry`** — the
highest sorry-rate of any category triaged so far (rounds 1-3 each found
at least one proof-complete candidate). Specifically:
- `1609.08688/sIncreasingrTuples.lean` (Gowers-Long s-increasing r-tuples):
  4 `research solved` theorems, all `sorry` (real analytic-combinatorics
  bounds).
- `2208.14736/ZariskiCancellation.lean`: 3 `research solved` variants,
  all `sorry` (algebraic geometry).
- `2602.05192/FirstProof4.lean`: 3 `research solved` theorems, all
  `sorry` (one with an unreplayed external `formal_proof` link).
- `2602.05192/FirstProof6.lean`, `math.0110202/BanachMazurRotation.lean`,
  `2504.17644/Margulis.lean`, `2303.01089/FurstenbergTimesPTimesQ.lean`:
  1 `research solved` theorem each, all `sorry`.
- `0911.2077/Conjecture6_3.lean`, `1308.0994/BoxdotConjecture.lean`: 1
  `research solved` theorem each, both with unreplayed external
  `formal_proof` links AND `sorry` in this file (same pattern as
  `#1052`'s AlphaProof link / `Books/BorweinSineSeries.lean`).

**Round-4 verdict**: `Arxiv/` is now fully triaged and confirmed to have
**zero** tractable candidates — do not re-check this category. Full
detail per-file in `SOURCE_MAP.md`.

### Triaged this cycle, round 5 — `OEIS/` (7 files, this agent, 2026-07-08)

- `34693.lean::exists_k_best_possible` — **genuinely proof-complete, a
  real win**: disproves the candidate upper bound `1 + n^0.74` for A34693
  via witness `n=19`. Self-contained (no custom `def`/`class`/`inductive`
  dependency at all — pure `Real`/`Nat.Prime` arithmetic). **Packetized**
  as `frontier.formal_conjectures.oeis_a34693_exists_k_best_possible.v1`
  — but hit a NEW blocker class first: the upstream proof term's
  `Real.nthRoot` doesn't resolve under this repo's pinned Mathlib
  revision at all (`kernel_fail`, "Unknown constant `Real.nthRoot`");
  `mathlib_search_declarations` confirmed this environment's own
  `nthRoot` is a different, Nat-valued function. Restated the goal via
  `Real.rpow` directly (`n ^ (74/100 : ℝ)`, mathematically identical to
  `nthRoot 100 n ^ 74` for `n ≥ 0`) and re-derived the same bound through
  `Real.rpow_natCast`/`Real.rpow_mul`/`pow_le_pow_iff_left₀` instead of
  the upstream `nthRoot`-unfolding lemmas — kernel_verified on the second
  attempt (episode `406c3860-6fcf-40b3-82a5-4a3a1726a89f`; see
  `BLOCKERS.md` for the full general lesson on cross-Mathlib-revision API
  drift between the sibling checkout and this repo).
- `358684.lean::oeis_358684_conjecture_0` — **also genuinely
  proof-complete**, no custom class/inductive (only file-local `def`s `a`
  and `a'`, both plain `def`s so transportable via `SubmitModule` in
  principle). Not attempted this cycle — noticeably larger and more
  involved (Fermat numbers, `padicValNat`, `Nat.log2`, several supporting
  lemmas) than `34693`'s single-witness proof, and this cycle's target
  budget was already spent on `34693`. **Flagged as a ready candidate for
  a future cycle** (would need `SubmitModule` with `a`/`a'` as `def`
  items plus the root theorem, and a check of whether ITS proof also
  references any Mathlib API that doesn't resolve here).
- `357513.lean`, `6697.lean`, `80170.lean`, `87719.lean` — all four
  `research solved` theorems have an external `formal_proof` link AND a
  `sorry` body in this file (same "linked but not replayed" pattern as
  `#1052`'s AlphaProof link / `Books/BorweinSineSeries.lean` / several
  `Arxiv/` round-4 files). Not tractable without replaying the linked
  external proof.
- `63880.lean::exists_primitive_of_a` — genuine `sorry`, needs an
  original primitive-term-decomposition argument. Out of scope.

**Round-5 verdict**: 2/7 `OEIS/` files are genuinely proof-complete
(`34693`, `358684`); one (`34693`) packetized this cycle after resolving
a new cross-Mathlib-revision API-drift blocker class (see `BLOCKERS.md`),
the other (`358684`) flagged as a ready candidate for a future cycle. The
remaining 5 are either genuine `sorry` or the "linked external proof, not
replayed" pattern. `OEIS/` triage is now complete — do not re-check.

### Triaged this cycle, round 6 — `Paper/` (12 files, this agent, 2026-07-08)

- `CasasAlvero.lean` — 3 `research solved` theorems, all `sorry` (one
  additionally has an external `formal_proof` link, "linked but not
  replayed" pattern).
- `ClaudesCycles.lean` — 2 `research solved` theorems, both `sorry` (one
  with an external `formal_proof` link).
- `ConjugacyClassSizes.lean` — 1 `research solved` theorem, `sorry`.
- `DeGiorgi.lean` — 4 `research solved` theorems (`DeGiorgi_ge_nine`,
  `DeGiorgi_one`, `DeGiorgi_two`, `DeGiorgi_three`). **`DeGiorgi_one` is
  the round's only genuinely proof-complete theorem** (real ~15-line
  tactic proof, no `sorry`) — but it's **infrastructure-heavy**, matching
  the round-1 `OpenQuantumProblems/` verdict rather than the Erdős-lane
  quick-win pattern: proving `DeGiorgi_conclusion 1` requires the
  STATEMENT itself (not just the proof) to reference a custom
  `structure IsBoundedSolution` (fields `regular`/`bounded`/`solution`)
  plus three more file-local `def`s (`HasPositiveDeriv`,
  `HasHyperplaneLevelSets`, `DeGiorgi_conclusion`) and heavy Mathlib
  machinery (`Δ`/Laplacian notation, `EuclideanSpace`, `AffineSubspace`,
  `lineDeriv`). Unlike the `EquationalTheories`/`Magma` case, the
  structure here can't be "erased via restatement" the same way: even
  though `DeGiorgi_one`'s proof never destructures `IsBoundedSolution`'s
  fields (only `HasPositiveDeriv` is actually used), the STRUCTURE ITSELF
  is part of `DeGiorgi_conclusion`'s definition, which the root statement
  must reference to be a faithful copy of the actual conjecture — not
  a `SubmitModule` blocker in the narrow sense (all three custom `def`s
  ARE transportable as `def` items in principle, and `IsBoundedSolution`
  being all-Prop-fields COULD in principle be inlined as a bare `And`
  chain instead of a named `structure`), but a much larger transport
  lift than a one-cycle target given the amount of supporting API
  (`strictMono_of_deriv_pos`, `deriv_comp_const_add`,
  `AffineSubspace.coe_affineSpan_singleton`, `preimage_image_eq`, plus
  `aesop`/`grind` automation whose behavior isn't yet verified under this
  repo's pinned Mathlib). The other 3 theorems (`ge_nine`, `two`,
  `three`) are genuine `sorry` (real hard PDE/geometric-measure-theory
  content regardless).
- `DegreeSequencesTriangleFree.lean` — 5 `research solved`
  theorems/defs, all `sorry`.
- `Gourevitch.lean` — 1 `research solved` theorem (a hypergeometric
  series identity for `32/π³`), `sorry`.
- `LatinSquare.lean` — 2 `research solved` theorems, both `sorry` (one
  also has an `answer(sorry)` placeholder pattern).
- `MonochromaticQuantumGraph.lean` — many `research solved` theorems, ALL
  `sorry`; most also carry external `formal_proof` links (DeepMind prover
  agent proofs, "linked but not replayed" pattern, same as `#1052`'s
  AlphaProof link).
- `Rupert.lean` — 1 `research solved` theorem, `sorry` (external
  `formal_proof` link).
- `VoronovskajaTypeFormula.lean` — 1 `research solved` theorem
  (`bernstein_operators`), `sorry`.
- `WeaklyFirstCountable.lean` — 1 `research solved` theorem, `sorry`.
- `ZagierMZV.lean` — 1 `research solved` theorem, `sorry`.

**Round-6 verdict**: 0/12 `Paper/` files yield a one-cycle transportable
win. `DeGiorgi_one` is genuinely proof-complete but infrastructure-heavy
(flagged for a possible dedicated multi-cycle push, not a quick win — see
`BLOCKERS.md`). `Paper/` triage is now complete — do not re-check.

### Not yet triaged

`Wikipedia/` (60 files), `GreensOpenProblems/` (30), `WrittenOnTheWallII/`
(21) — a future cycle should continue this same triage (`grep -B1 -A3
"category research solved"` per file, check for a bare `sorry` body vs. a
real proof, check whether real proofs are self-contained vs.
infrastructure-heavy — including whether custom types are needed just to
STATE the theorem, not only to prove it — check whether a
`class`/`structure` blocker is load-bearing or notational, and check
whether unusual API names actually resolve under this repo's pinned
Mathlib before assuming a verbatim transport will compile — see
`BLOCKERS.md`). `WrittenOnTheWallII/` (21) is now the smallest untriaged
category (`Arxiv/`, `OEIS/`, `Paper/` are all done, see rounds 4-6
above).

## Backlog

- [ ] `HilbertProblems/` — triaged this cycle (see above); both files'
      `research solved` theorems are genuinely `sorry` and genuinely hard
      (5th/17th problems). Not a near-term target.
- [x] `EquationalTheories_677_255.lean`'s class-free restatement (see
      round 3 above) — **packetized 2026-07-08**:
      `packets/frontier/formal_conjectures/equational_theories_677_255_class_free.v1.json`,
      episode `39013082-f757-41f2-b26b-420d7577a454`, kernel_verified on
      the first `Solve` attempt with the exact sketched proof term
      (`refine ⟨fun i j => i + j + 1, fun x => by fin_cases x <;>
      decide, ?_⟩; decide`). First packet authored in this lane.
      `training.eligibility: quarantined` (conservative default, even
      though `open_problem_related: false` for this specific theorem —
      no established public_train precedent yet for this lane).
- [x] `OEIS/34693.lean::exists_k_best_possible` (see round 5 above) —
      **packetized 2026-07-08**:
      `packets/frontier/formal_conjectures/oeis_a34693_exists_k_best_possible.v1.json`,
      episode `406c3860-6fcf-40b3-82a5-4a3a1726a89f`, kernel_verified.
      Restated via `Real.rpow` after the upstream `Real.nthRoot` failed
      to resolve — see `BLOCKERS.md` for the general API-drift lesson.
- [x] `OEIS/358684.lean::oeis_358684_conjecture_0` (see round 5 above) —
      **packetized 2026-07-08**:
      `packets/frontier/formal_conjectures/oeis_a358684_conjecture_0.v1.json`,
      episode `8bf75cf7-35f9-4c10-8015-3a9411a6df52`, kernel_verified on
      the third attempt after three repairs (unqualified `sub_le` ->
      `Nat.sub_le`; `norm_num` can't discharge `fermatNumber n ≠ 1` for
      symbolic `n`, needed `Nat.fermatNumber_ne_one`; needed an explicit
      `intro n`). `a n` inlined as its closed form in the root statement
      (no separate `def`, since `problem_create`'s statement must be
      self-contained). Also noted: the upstream file's own proof for this
      theorem opens with `delta fermatNumber and a`, which looks like a
      stray erroneous token (`delta` has no `and` combinator) — this
      packet's proof was built independently rather than trusting that
      script verbatim; see the packet's `notes` field.
