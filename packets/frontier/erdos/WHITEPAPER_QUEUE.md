# Whitepaper Queue — Erdős Frontier

Results strong enough to warrant inclusion in the sibling repo's
`ErdosProblems/whitepaper.md` or a standalone writeup. A result only
qualifies once it is Lean-verified through a tracked episode and has passed
source review. The six rows below are already Lean-verified in the sibling
repo (2026-07-07) — the remaining step for each is packetization into
MathCorpus, not further proof work.

| Result | Status | Verified | Source reviewed | Notes |
|--------|--------|----------|--------------------|-------|
| #349 integer-characterization cluster (`integer_isGoodPair_iff`) | COMPLETE, 7 theorems | yes (tracked episodes) | no | `ErdosProblems/erdos-349/` — all milestones DONE per its attack-plan.md |
| #1052 unitary perfect numbers are even (Subbarao–Warren 1966) | companion proved | yes | no | `ErdosProblems/erdos-1052/` — first standalone-reproducible proof; corpus ships it as `sorry` |
| #291.ii `gcd(aₙ,Lₙ)>1` infinitely often (Steinerberger) | companion proved | yes | no | `ErdosProblems/erdos-291/` — corpus ships as `sorry` |
| #399 Cambie's `n! ≠ x⁴+y⁴` companion | companion proved | yes | no | `ErdosProblems/erdos-399/` — corpus ships as `sorry` |
| #494 product version is false (Steinerberger counterexample) | companion proved | yes | no | `ErdosProblems/erdos-494/` — corpus ships `research solved` as `sorry` |
| #1113 infinitely many Sierpiński numbers (Sierpiński 1960) | companion proved | yes, purely kernel (no native_decide) | no | `ErdosProblems/erdos-1113/` — corpus ships `research solved` as `sorry` |

Lower priority (pipeline-calibration artifact, not a headline result):

| Result | Status | Verified | Source reviewed | Notes |
|--------|--------|----------|--------------------|-------|
| #1 weaker known subset-sum bound (calibration case study) | reproved for pipeline audit | yes | no | `ErdosProblems/erdos-1/` — explicitly not a solve of #1 itself; packetize only if a calibration/methodology packet is wanted |
