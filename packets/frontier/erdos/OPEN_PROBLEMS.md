# Open Problems — Erdős Frontier

Genuinely open Erdős problems tracked from this workspace. Cross-checked
against the sibling repo's `ErdosProblems/` and `docs/erdos/bounty-board.md`
(2026-07-07). **Do not treat any of these as proof targets** — see the
anti-hype rule in `README.md`. This lane exists to track them, build
dossiers, and packetize already-proved *companions* (see
`COMPANION_RESULTS.md`), never to claim the open question itself.

| Problem | Status | Source | Notes |
|---------|--------|--------|-------|
| #1 distinct subset sums | OPEN, prize $500 | `ErdosProblems/erdos-1/whitepaper.md` | our #1 folder only reproves a weaker known bound for pipeline calibration |
| #9 odd `n ≠ p+2^k+2^l` (Crocker) | OPEN (headline); large covering construction IN PROGRESS in sibling repo | `ErdosProblems/erdos-9/attack-plan.md` | see `PARTIAL_RESULTS.md` for the banked lemma |
| #291.i `gcd(aₙ,Lₙ)=1` infinitely often | OPEN | `ErdosProblems/erdos-291/whitepaper.md` | part ii (different, easier claim) is proved — see `COMPANION_RESULTS.md`; do not conflate the two |
| #672 4-term AP product never a perfect square, general case (Euler) | OPEN (headline framing varies by source); arithmetic core IN PROGRESS in sibling repo | `ErdosProblems/erdos-672/attack-plan.md` | see `PARTIAL_RESULTS.md` |
| #1052 finitely many unitary perfect numbers? | OPEN | `ErdosProblems/erdos-1052/whitepaper.md` | companion (even-ness) proved; structural partial bound also proved — see `PARTIAL_RESULTS.md` |
| #470 are there odd weird numbers? | OPEN since 1974, prize $10 | `docs/erdos/bounty-board.md` | positive-density companion (`weird_pos_density`) ships as `sorry`, not yet attempted — see `COMPANION_RESULTS.md` |

## Bounty-board reference (not yet attempted, tracked for triage)

`docs/erdos/bounty-board.md` lists 30 open+formalized+prize>0 targets from
`teorth/erdosproblems`. Its own "honest triage" identifies three
system-rational lanes worth re-checking periodically rather than working
the whole list:

- **Lane 2** (statement contributions): `#20`, `#30` carry literal
  `TODO: add the various known bounds as variants` comments in the corpus.
- **Lane 3** (finite/certificate sub-cases): `#564` (hypergraph Ramsey lower
  bounds via explicit colourings), `#592`, `#241`/`#39`/`#41` (Sidon sets —
  finite instances are `decide`/`bv_decide`-shaped).

These are **not** MathCorpus packet targets on their own (they're
statement/certificate infrastructure in the sibling repo, not proved
results) — track here only as awareness, act on them in the sibling repo
first.
