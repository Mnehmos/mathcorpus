# Partial Results — Erdős Frontier

Sublemmas, finite certificates, and bounded partial progress toward a
target. Must clearly state what fraction/case of the problem is covered.
Rows below reflect sibling-repo state as of 2026-07-07 — these are
**in-progress**, not packet-ready (contrast with `COMPANION_RESULTS.md`,
whose rows are already complete and Lean-verified).

| Result | Target problem | Case/bound covered | Lean status | Packet |
|--------|------------------|----------------------|-------------|--------|
| `odd_add_one_dvd_pow_add_one` + banked Fermat-number divisibility lemma | #9 (Crocker, odd `n ≠ p+2^k+2^l`) | one banked lemma of a larger multi-part covering construction | kernel_verified (banked in `lean-checker/LeanChecker/Erdos/Erdos9.lean`) | (none — too partial to packetize as a standalone result yet) |
| `ω_odd(n) ≤ ν₂(n)+1` structural bound (Lean name: `omega_odd_le_two_adic_add_one`) — human commentary combines this with Wall's *unformalized* 1988 theorem | #1052 (finitely many unitary perfect numbers?) | Lean-proved: `card m.primeFactors <= a + 1`. NOT Lean-proved: the "forces any 6th unitary perfect number divisible by 2^8=256" consequence, which additionally needs Wall's theorem (cited, not formalized) | kernel_verified in sibling repo (source-reviewed here 2026-07-08, not yet re-verified in this repo's own tracked loop) | (none yet — source-reviewed, see `SOURCE_REVIEW.md` for the full dependency chain and an explicit anti-overclaim phrasing requirement; **not standalone-packetizable yet** — depends on `sigmaStar_mul_of_coprime`/`sigmaStar_prime_pow`, which should land first as their own packet closing `COMPANION_RESULTS.md`'s "General σ* multiplicativity" row) |
| `euler_four_ap` arithmetic core (in progress) | #672 (Euler: 4-term AP product never a perfect square, `gcd(n,d)=1`) | arithmetic core only, multi-session marathon per `ErdosProblems/erdos-672/attack-plan.md` | in progress, not yet fully kernel-verified | (none — not ready) |

Do not auto-fire repeatedly at #9 or #672 — both are explicitly flagged
"large multi-part" / "multi-session marathon" in their own attack plans in
the sibling repo. Check those attack-plan.md files for the current
milestone before picking either up. Same caution now applies to the
`omega_odd_le_two_adic_add_one` row above: it is a genuine multi-lemma
`SubmitModule` transport (this lane's `#291.ii`/`#494` precedent: ~4
attempts each for smaller modules), not a one-cycle target — see
`SOURCE_REVIEW.md`'s transport note before attempting it.
