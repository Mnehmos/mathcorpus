# MathCorpus Status

Corpus-wide status for the MathCorpus agent workspace. Owned by the dev
loop agent (`agents/github_issues/`); domain agents propose updates rather
than editing directly. Re-derive with `python tools/corpus_stats.py` where
available; this snapshot was computed by hand at scaffold time
(2026-07-07).

## Corpus totals (measured, 2026-07-07)

| Metric | Value |
|--------|-------|
| Total packets | 190 |
| Elementary (public) | 189 |
| Negative examples | 1 |
| v0.1 target (`docs/roadmap.md`) | >=250 public packets, >=25 negative examples |
| Progress to v0.1 (public) | 189 / 250 (~76%) |
| Progress to v0.1 (negative) | 1 / 25 (~4%) |

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

1 packet: `packets/negative/geometry/angle_atoms_nlinarith_failure.v1.json`.
16 more domain lanes exist under `packets/negative/*` at scaffold time but
are empty — the roadmap's >=25 negative-example release criterion is the
biggest current gap.

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

Induction (6 packets) is furthest behind; negative examples across every
domain are the single biggest gap versus the v0.1 release criteria.

## Known environment bugs / workarounds

- Attempt-claim burst-concurrency: use sub-waves of 7 proof attempts until
  fixed; track in `agents/github_issues/BUGS.md`. On an invalid claim
  response, re-observe, then re-claim with a fresh idempotency key if still
  pending.

## Current safe batch size

Sub-waves of 7 proof attempts.
