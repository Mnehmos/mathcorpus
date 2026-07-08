# MathCorpus Status

Corpus-wide status for the MathCorpus agent workspace. Owned by the dev
loop agent (`agents/github_issues/`); domain agents propose updates rather
than editing directly. Re-derive with `python tools/corpus_stats.py` where
available; this snapshot was hand-updated 2026-07-08 by the induction domain agent
after adding `two_pow_gt_self` + its paired negative example (proposed
update — dev loop agent should confirm against a fresh `corpus_stats.py`
run; other domain agents are committing concurrently, so treat exact
counts as approximate until re-derived).

## Corpus totals (measured, 2026-07-08)

| Metric | Value |
|--------|-------|
| Total packets | 197+ |
| Elementary (public) | 190+ |
| Negative examples | 7+ |
| v0.1 target (`docs/roadmap.md`) | >=250 public packets, >=25 negative examples |
| Progress to v0.1 (public) | 190 / 250 (~76%) |
| Progress to v0.1 (negative) | 7 / 25 (~28%) |

Note: `packets/negative/functions/injective_add_decide_failure.v1.json` is
stamped, schema-validated (`validate_packets.py --check-hashes
--warn-as-error`: 0 errors), and committed (landed in commit `88b7dea`
alongside the combinatorics packet, since it was staged when that commit
ran) — count it. `domain: algebra` on that packet is intentional, not an
error: it matches every other packet filed under the `functions` folder,
because `functions` is not a valid `domain` enum value in
`schema/packet.schema.json`.

## Elementary domain distribution (measured)

| Domain | Packets | Levels |
|--------|---------|--------|
| Algebra | 41 | L0: 33 · L1: 2 · L2: 6 |
| Number theory | 48 | L0: 23 · L1: 24 · L2: 1 |
| Combinatorics | 33 | L0: 10 · L1: 23 |
| Geometry | 29 | L0: 3 · L1: 23 · L2: 3 |
| Induction | 7 | L0: 1 · L1: 6 |
| Inequalities | 16 | L0: 2 · L1: 2 · L2: 12 |
| Functions | 16 | L0: 8 · L1: 8 |

All 189 elementary packets are `status: kernel_verified`.

## Negative examples

5 packets:
- `packets/negative/geometry/angle_atoms_nlinarith_failure.v1.json`
- `packets/negative/algebra/nat_sub_ring_trap.v1.json` (added 2026-07-08:
  `ring` fails on a `ℕ` truncated-subtraction cancellation because it
  ignores the ordering hypothesis; `omega` closes it)
- `packets/negative/combinatorics/finset_card_atoms_omega_failure.v1.json`
  (added 2026-07-08: `omega` applied directly to the four `Finset.card`
  atoms in the inclusion-exclusion identity `(s ∪ t).card + (s ∩ t).card =
  s.card + t.card` reports a spurious counterexample, since it has no
  built-in knowledge of the Finset union/intersection cardinality
  relationship; produced via tracked episode
  `29b897d0-2c51-4a9b-8bb4-5f781b0a753c`, closed with `give_up`)
- `packets/negative/number_theory/divisor_case_split_omega_unevaluated_literal.v1.json`
  (added 2026-07-08: `omega` applied to the divisibility goal
  `(3 + (-1) : ℤ) ∣ 88` — a literal-valued but syntactically unreduced
  divisor left behind by a case split — reports a spurious counterexample
  via `88 % (3 + -1)`; `norm_num` normalizes the divisor and closes it;
  produced via tracked episode `a0318540-bab0-4952-87f4-5f84129b5c3e`,
  reaching `kernel_verified` on the repair step)
- `packets/negative/functions/injective_add_decide_failure.v1.json` (added
  2026-07-08: `decide` fails to elaborate on `Function.Injective (fun n :
  ℕ => n + 5)` — no `Decidable` instance exists for a `∀`-goal over an
  infinite domain; produced via tracked episode
  `2874844f-84d1-476e-92b9-5cfe043a88cf`, closed with `give_up`)
- `packets/negative/inequalities/three_var_sq_bare_nlinarith_failure.v1.json`
  (added 2026-07-08: bare `nlinarith` — no hint terms — fails on
  `a^2+b^2+c^2 >= a*b+b*c+c*a` over ℝ with `linarith failed to find a
  contradiction`, since it doesn't synthesize the needed `sq_nonneg (a-b)`
  /`(b-c)`/`(a-c)` witnesses on its own; `nlinarith [sq_nonneg (a - b),
  sq_nonneg (b - c), sq_nonneg (a - c)]` then closes the same tracked
  episode `d1e875d2-1cef-45c1-a76e-d46e84f67aa9` `kernel_verified`)

- `packets/negative/induction/pow_succ_atom_nlinarith_failure.v1.json`
  (added 2026-07-08: `nlinarith [ih]` applied directly to the induction
  successor goal `n + 1 < 2 ^ (n + 1)` (proving `n < 2 ^ n`) fails because
  it treats `2 ^ (n + 1)` and `2 ^ n` as unrelated opaque atoms with no
  built-in `pow_succ` recurrence; `rw [pow_succ]; nlinarith [ih]` then
  closes it. Produced via tracked episode
  `5a175c43-1c93-4cf7-a4e9-5038e1961068`; the follow-up fix in the same
  episode reached `kernel_verified` and was authored as
  `packets/elementary/induction/two_pow_gt_self.v1.json`, closing the
  induction elementary QUEUE.md's `two_pow_gt_self` target.)

Every domain lane now has at least one committed negative example — the
roadmap's >=25 negative-example release criterion (currently ~7/25) is
still the biggest raw-count gap, but the "zero coverage" gap across
domains is closed.

## Frontier (Phase 5)

Not started. `packets/frontier/formal_conjectures` and
`packets/frontier/erdos` are scaffolded (dossiers/queues only), zero
packets.

## Validation status

All 190 packets pass `tools/validate_packets.py` as of the last recorded
green CI run on `main`; re-check after scaffolding since this run added
markdown files (not packets — CI globs `*.json` only, verified safe).

## Redaction audit status

Not re-run since scaffolding (no packet content changed).

## CI status

`.github/workflows/ci.yml` — `corpus` job gates schema/hash/manifest/
redaction on every PR touching `packets/`, `schema/`, or `tools/`; `lean`
job is disabled (`if: false`) pending a pinned toolchain/mathlib rev.

## Current target

Close the negative-example gap (6 -> 25) and continue elementary bulk
(189 -> 250) per `docs/roadmap.md` Phase 2/6 prioritization
("Redaction and benchmark quarantine before public release" means
negative-example coverage matters before a v0.1 cut, not just raw count).

## Recommended next domains

Induction (7 packets) is still furthest behind on the elementary spine —
see `packets/elementary/induction/QUEUE.md` for queued targets
(`bernoulli_inequality`, `sum_evens`, `geom_series_sum_induction`,
`factorial_ge_two_pow`). Negative examples remain the single biggest gap
versus the v0.1 release criteria (~7/25); every domain lane now has at
least one, so the next priority is raw count, not coverage.

## Known environment bugs / workarounds

- Attempt-claim burst-concurrency: use sub-waves of 7 proof attempts until
  fixed; track in `agents/github_issues/BUGS.md`. On an invalid claim
  response, re-observe, then re-claim with a fresh idempotency key if still
  pending.

## Current safe batch size

Sub-waves of 7 proof attempts.
