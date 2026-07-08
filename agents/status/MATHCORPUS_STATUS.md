# MathCorpus Status

Corpus-wide status for the MathCorpus agent workspace. Owned by the dev
loop agent (`agents/github_issues/`); domain agents propose updates rather
than editing directly. Re-derive with `python tools/corpus_stats.py` where
available; this snapshot was hand-updated 2026-07-08 after a number_theory
negative-example packet (proposed update — dev loop agent should confirm
against a fresh `corpus_stats.py` run).

## Corpus totals (measured, 2026-07-08)

| Metric | Value |
|--------|-------|
| Total packets | 193 |
| Elementary (public) | 189 |
| Negative examples | 4 |
| v0.1 target (`docs/roadmap.md`) | >=250 public packets, >=25 negative examples |
| Progress to v0.1 (public) | 189 / 250 (~76%) |
| Progress to v0.1 (negative) | 4 / 25 (~16%) |

Note: one more negative-example candidate was seen in the working tree
but is **uncommitted and unstamped** at the time of this snapshot —
`packets/negative/functions/injective_add_decide_failure.v1.json`
(`hashes.packet_sha256` is a placeholder and its `domain` field says
`algebra` while it lives under the `functions` folder) — apparently
another agent's in-progress work. Do not count it until it's stamped,
validated, and committed by its owning agent.

## Elementary domain distribution (measured)

| Domain | Packets | Levels |
|--------|---------|--------|
| Algebra | 41 | L0: 33 · L1: 2 · L2: 6 |
| Number theory | 48 | L0: 23 · L1: 24 · L2: 1 |
| Combinatorics | 33 | L0: 10 · L1: 23 |
| Geometry | 29 | L0: 3 · L1: 23 · L2: 3 |
| Induction | 6 | L1: 6 |
| Inequalities | 16 | L0: 2 · L1: 2 · L2: 12 |
| Functions | 16 | L0: 8 · L1: 8 |

All 189 elementary packets are `status: kernel_verified`.

## Negative examples

4 packets:
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

3 more domain lanes (`functions`, `induction`, `inequalities`) are still
empty in the committed corpus — the roadmap's >=25 negative-example
release criterion is the biggest current gap.

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

Close the negative-example gap (1 -> 25) and continue elementary bulk
(189 -> 250) per `docs/roadmap.md` Phase 2/6 prioritization
("Redaction and benchmark quarantine before public release" means
negative-example coverage matters before a v0.1 cut, not just raw count).

## Recommended next domains

Induction (6 packets) is furthest behind on the elementary spine; negative
examples remain the single biggest gap versus the v0.1 release criteria —
`induction` and `inequalities` still have zero committed negative-example
packets (`functions` has one uncommitted/unstamped candidate in progress;
see note above).

## Known environment bugs / workarounds

- Attempt-claim burst-concurrency: use sub-waves of 7 proof attempts until
  fixed; track in `agents/github_issues/BUGS.md`. On an invalid claim
  response, re-observe, then re-claim with a fresh idempotency key if still
  pending.

## Current safe batch size

Sub-waves of 7 proof attempts.
