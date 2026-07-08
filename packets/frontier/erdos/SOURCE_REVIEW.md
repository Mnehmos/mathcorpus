# Source Review — Erdős Frontier

| Source | Claim reviewed | Reviewer | Date | Verdict |
|--------|------------------|----------|------|---------|
| `ErdosProblems/erdos-399/proof/Erdos399_cambie.lean` (sibling repo) + `erdosproblems.com/399` | Cambie's companion (no `n! = x⁴+y⁴` with `gcd(x,y)=1`, `xy>1`) is correctly attributed and distinct from Erdős #399's own headline question (already answered non-solution-free via Barfield's `10! = 48⁴−36⁴`, an unrelated construction) | this agent (self-review) | 2026-07-08 | Statement and attribution check out against the sibling repo's docstring; proof independently re-verified through this repo's own tracked proof-search loop (episode `d2aaae74-a8c1-406a-a196-ce132e64307e`, `kernel_verified`) rather than trusted on the sibling repo's say-so. Self-review only — not an external/independent reviewer, hence `training.eligibility: quarantined` on the packet pending real external review. |
| `ErdosProblems/erdos-1052/proof/Erdos1052_sigmaStar_and_bounds.lean::omega_odd_le_two_adic_add_one` (sibling repo) + `evidence.md`'s Wall citation | The `PARTIAL_RESULTS.md`-flagged "candidate standalone packet once source-reviewed": for a unitary-perfect `2^a * m` (`m` odd, `a >= 1`), `m.primeFactors.card <= a + 1`, framed in the docstring as "combined with Wall's 1988 theorem forces `a >= 8` for a 6th unitary perfect number" | this agent (self-review; not yet re-verified through this repo's own tracked proof-search loop) | 2026-07-08 | See detailed notes below. |

## Detailed notes — `omega_odd_le_two_adic_add_one` (2026-07-08)

**What is actually Lean-proved** (read the full theorem body + its two
dependencies in the sibling file): a clean 2-adic-valuation counting
argument. `sigmaStar_prime_pow` gives `sigmaStar (2^a) = 2^(a+1) - 1`
(odd), `sigmaStar_mul_of_coprime` (the from-scratch σ*-multiplicativity
theorem, itself flagged `(none yet)` in `COMPANION_RESULTS.md`'s
"General σ* multiplicativity" row — **this packet's own dependency, so
it should ship together with or after that infrastructure theorem, not
independently**) splits `sigmaStar(2^a * m) = sigmaStar(2^a) * sigmaStar(m)`.
Comparing the 2-adic valuation of both sides of `sigmaStar(2^a)*sigmaStar(m)
= 2^(a+1)*m` (via `Nat.factorization_mul` at prime 2, `2^a+1` and `m` both
odd so contribute 0) forces `(sigmaStar m).factorization 2 = a+1`; a prior
theorem in the same file, `two_pow_card_primeFactors_dvd_sigmaStar` (strong
induction on `m`'s prime factorization), gives `2^(card m.primeFactors) ∣
sigmaStar m`, so `card m.primeFactors <= (sigmaStar m).factorization 2 = a+1`.
**Chain of Lean dependencies for a future packet, all in the same sibling
file:** `sigmaStar_mul_of_coprime` -> `sigmaStar_prime_pow` ->
`two_pow_card_primeFactors_dvd_sigmaStar` -> `omega_odd_le_two_adic_add_one`.
Mathematically sound; matches the sketch in `attack-plan.md` M3.

**What is NOT Lean-proved, and the docstring is honest about this**: the
"forces `a >= 8`" / "9 distinct odd prime factors" claim requires Wall's
1988 theorem, which is *not* formalized anywhere in this stack — it is
cited as an external, unformalized fact (`evidence.md`: "Wall, 'New
unitary perfect numbers have at least nine odd components,' Fibonacci
Quarterly"). **Anti-overclaim requirement for any future packet**: the
formal statement and `informal_statement` must state only the Lean-proved
bound (`card m.primeFactors <= a + 1`); the Wall-theorem consequence
belongs in `notes`/commentary only, clearly marked as citing an external,
unformalized result, exactly as `docs/erdos/bounty-board.md`'s and this
folder's `README.md` anti-hype conventions already require elsewhere in
this lane. Do not phrase the packet's title or `informal_statement` as
"any 6th unitary perfect number needs >= 256" — that combines a Lean fact
with a non-Lean citation and would overclaim.

**Transport note** (from `proof-narrative.md`'s account of the *sibling*
`even_of_isUnitaryPerfect` proof, which faced the same module): helper
lemmas in this environment's `SubmitModule` are force-flattened regardless
of `proof_format`, and this file's proofs lean on `Finset.sum_nbij'`/
bullet-heavy case splits in several helper lemmas
(`sigmaStar_mul_of_coprime`, `two_pow_card_primeFactors_dvd_sigmaStar`)
that would need bullet-free rewrites to survive that flattening. Given the
dependency chain above needs 3-4 upstream lemmas transported together,
budget for a genuine multi-attempt `SubmitModule` cycle (this lane's own
precedent: the `#291.ii`/`#494` modules each took ~4 attempts) — **not a
one-cycle target**; a future frontier cycle should attempt
`sigmaStar_mul_of_coprime` + `sigmaStar_prime_pow` as their own
foundational packet first (closing `COMPANION_RESULTS.md`'s "General σ*
multiplicativity" row), then build `omega_odd_le_two_adic_add_one` on top
of the now-packetized, cited infrastructure rather than re-deriving it
inline.

**Verdict**: statement and attribution check out; mathematically sound;
not yet re-verified through this repo's own tracked proof-search loop
(no `episode_id` to cite). Cleared for packetization *once* the
`sigmaStar_mul_of_coprime`/`sigmaStar_prime_pow` infrastructure lands
first, and only with the anti-overclaim phrasing above. `PARTIAL_RESULTS.md`
updated accordingly.
