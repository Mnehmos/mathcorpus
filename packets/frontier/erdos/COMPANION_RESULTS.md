# Companion Results — Erdős Frontier

Known, already-solved companion theorems that support an Erdős target
(e.g. bounds, special cases, or classical results the open problem builds
on). Safe to packetize once Lean-verified — these do **not** count as
solving the open problem itself. Rows below are already Lean-verified in
the sibling repo (`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\`,
2026-07-07); "Packet" is empty until authored here.

| Result | Supports problem | Lean status | Source repo path | Packet |
|--------|--------------------|-------------|---------------------|--------|
| `integer_isGoodPair_iff` cluster (7 thms) | #349 | kernel_verified | `ErdosProblems/erdos-349/proof/` | 1/7 packetized: `frontier.erdos.erdos_349_exists_finset_sum_two_pow.v1` (2026-07-08, episode `a6801189-5441-43b8-a97d-05f46ee9be32`, single Solve step, `root_statement_hash` confirmed byte-identical to the upstream `formal-conjectures` source hash cited in the sibling repo's own provenance comment; `training.eligibility: quarantined`, same policy as the #399 row). The remaining 6 files in that folder are larger (31-279 lines) and not yet attempted — `Erdos349_integer_isGoodPair_iff.lean` (279 lines, the culminating assembly) is likely the highest-value next target. |
| Subbarao–Warren: unitary perfect numbers are even | #1052 | kernel_verified | `ErdosProblems/erdos-1052/proof/` | (none yet) |
| Steinerberger: `gcd(aₙ,Lₙ)>1` infinitely often | #291 (part ii) | kernel_verified | `ErdosProblems/erdos-291/proof/` | (none yet) |
| Cambie: no `n! = x⁴+y⁴` with `gcd(x,y)=1`, `xy>1` | #399 | kernel_verified | `ErdosProblems/erdos-399/proof/` | `frontier.erdos.erdos_399_cambie.v1` (2026-07-08, episode `d2aaae74-a8c1-406a-a196-ce132e64307e`, re-verified independently in this repo's own pinned toolchain; `training.eligibility: quarantined` per default-quarantine policy for `open_problem_related` packets pending external review) |
| Steinerberger counterexample: product version false | #494 | kernel_verified | `ErdosProblems/erdos-494/proof/` | (none yet) |
| Sierpiński (1960): infinitely many Sierpiński numbers | #1113 | kernel_verified, no native_decide | `ErdosProblems/erdos-1113/proof/` | (none yet) |
| General `σ*` multiplicativity (not in Mathlib before this work) | #1052 (infrastructure) | kernel_verified | `ErdosProblems/erdos-1052/` | (none yet) |

Also worth tracking from `docs/erdos/bounty-board.md`'s Lane 1 ("solved-with-`sorry` inside bounty files, immediate wins", not yet attempted in the sibling repo):

- `#470 erdos_470.variants.weird_pos_density` — weird numbers have positive
  density (Benkoski–Erdős 1974); ships as `sorry` in the corpus, no attempt
  made yet. Good next companion-result target before it's a MathCorpus
  packet.
