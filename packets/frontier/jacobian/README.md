# Jacobian Conjecture (Frontier)

The Jacobian lane for MathCorpus packets (`domain: frontier`,
`level: L7_frontier`, `source_provenance.source_kind: erdos_problems` is
**not** used here — see below): packetizing the machine-certified
formalization of the July 2026 **counterexample to the Jacobian Conjecture**.

Unlike the `erdos/` and `formal_conjectures/` lanes, whose headline problems
are open, this lane's headline result is a **certified disproof** of a specific
formalized statement — DeepMind `formal-conjectures`'
`jacobian_conjecture` — in dimension 3 (and, by stabilization, every dimension
≥ 3). What remains genuinely open is separated explicitly below and must never
be conflated with what is proved.

## Source of the work

The formal work already lives in a **sibling repository**, not here:

- `F:\Github\mnehmos.llm-driven-proof-search.environment\jacobian counter\`
  — the formal release: `ChallengeSolved.lean` (verbatim kernel-accepted
  proofs of theorems 1–5), `CollateralDamage.lean` (the sorry-free Poisson
  refutation + cited-open bridges), `certificates/` (11-var and 23-var exact
  sympy certificates), `README.md` / `whitepaper.md` / `proof-construction.md`.

Cross-reference that release before authoring here. This folder turns the
**already Lean-verified** theorems from that release into properly schema'd,
provenance-complete MathCorpus packets — it does not redo the proof-search.

## Attribution (source of record: the release README)

The counterexample is credited as follows in the release:

- **Question** posed by Akhil Mathew.
- **Counterexample** by L. Alpöge (2026-07-19).
- **Explicit construction** credited to the AI model Fable.
- **Families generalization** credited to GPT-5.6 Pro.
- **Write-up**: P. Chojecki, *A Counterexample to the Jacobian Conjecture*
  (ulam.ai research write-up, 2026-07-20; announced
  [@prz_chojecki](https://x.com/prz_chojecki)).

Every formal packet in this lane certifies that paper's Theorem 3.1
computations and their consequence for the conjecture — no more. The provenance
travels with each packet as MCIP `literature_source` + `idea_attribution`
evidence, emitted by the sibling repo's `mathcorpus_export` (#263) from the
tracked `literature_lineage` ledger. Peer review of the source announcement is
ongoing; a packet's `training.eligibility` stays `quarantined` until external
review, exactly like the open-problem lanes.

## The counterexample

```
F(x,y,z) = ( (1+xy)³z + y²(1+xy)(4+3xy),
             y + 3x(1+xy)²z + 3xy²(4+3xy),
             2x − 3x²y − x³z )  :  ℂ³ → ℂ³
```

- **det Jac F ≡ −2** — a Keller map (nonzero constant Jacobian determinant), yet
- **F(0,0,−1/4) = F(1,−3/2,13/2) = F(−1,3/2,13/2) = (−1/4,0,0)** — a collapsed
  fiber. A non-injective Keller map is not a polynomial automorphism,
  contradicting the conjecture in dimension 3.

## Certified vs. open (anti-overclaim rule)

Every packet in this lane MUST state, in `notes`, what it proves and what it
does not. The certified core is the map's defining computations and their
contradiction with polynomial invertibility (dims 3, 4) and injectivity.

**NOT proved / still open — never claim these in a packet:**

- The dimension-**two** problem (control of escape at infinity) — genuinely open.
- The paper's fiber/image/nonproperness geometry and general-n stabilization.
- The literature bridges to Dixmier / Mathieu / Zhao / cubic reduction — stated
  formally with citations in `CollateralDamage.lean`, proved only
  *conditionally* (on an explicit hypothesis), never unconditionally here.
- An explicit finite-type SU(3) moment witness.

The identification of the informal 1939 Keller conjecture with the
`formal-conjectures` statement is that repository's (reviewed, public)
formalization decision — a packet inherits it, it does not re-decide it.

## The certified theorems (sibling-repo release ledger)

| # | Claim | Problem / Episode | Outcome |
|---|-------|-------------------|---------|
| 1 | Symbolic det = C(−2) ∧ three-point collision (ℚ) | `29f88fb5` / `0c0afd37` | `kernel_verified` |
| 2 | **¬ Jacobian Conjecture** (ℂ, dim 3) — negated `formal-conjectures` instance | `654521be` / `1f9dfbee` | **`certified`** |
| 3 | F's evaluation map ℂ³ → ℂ³ not injective | `f3b97f2c` / `a8a4062d` | **`certified`** |
| 4 | ¬ Jacobian Conjecture (ℂ, dim 4), stabilized witness | `7312a555` / `591219bc` | **`certified`** |
| 5 | Normalized form U = (R/2, Q, P): det=1, U(0)=0, JU(0)=I, three-point fiber | `c270a9d2` / `c8d0d87c` | **`certified`** |
| 6 | Poisson-bridge computational core: J·B = −2·I + 27 cofactor identities | `a4044282` / `c25405a7` | **`certified`** |
| 7 | ¬PoissonStatement, unconditional (in `CollateralDamage.lean`) | — | file-verified, sorry-free |

`certified` = kernel-verified + hash-bound statement-fidelity review (the
environment's highest trust). Rows 2–6 carry `fidelity_status: verified`.

- Packet shape: see `PACKET_TEMPLATE.md`
- Run this folder: see `LOOP.md`

## Global Operating Rule

Do not let proof work escape the proof environment. Per
`docs/proofsearch-integration.md`: evidence is tracked proof-search actions and
Lean kernel verdicts; a model's hidden reasoning, a prior transcript, a paper's
claim, or a proof checked some other way are **candidates**, not evidence, until
the pinned Lean kernel checks them inside a tracked episode.

- If it proves the theorem, verify it through the Lean kernel inside a tracked
  episode. If it fails, keep it as a `negative_example` packet.
- Provenance (who posed / constructed / wrote up the result, and whether a
  source was model-visible) rides along as MCIP `literature_source` /
  `idea_attribution` evidence — never as proof authority.

Private reasoning is not proof authority. The Lean kernel decides. The ledger
records.
