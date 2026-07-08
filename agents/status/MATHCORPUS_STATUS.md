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

## Proposed update — number_theory negative example (this agent, 2026-07-08)

Added `packets/negative/number_theory/sq_parity_omega_nonlinear_failure.v1.json`:
`omega` applied directly to `n ^ 2 % 2 = n % 2` fails deterministically
(`kernel_fail`/`tactic_failure`) — it treats `n ^ 2` as an opaque nonlinear
atom unrelated to `n` and cannot connect the two parities. Produced via
tracked episode `7381250f-097a-4151-b5ba-0e80303ff42e` (problem_version
`3ea68a09-d6cb-48e6-9b8e-b226d225268a`, dev-attested), closed with
`give_up` after one rejected solve attempt; no repair/fix step attempted
this cycle. This is number_theory's 2nd negative example, alongside
`divisor_case_split_omega_unevaluated_literal.v1.json`. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and hash-stamped.

This appended as a section rather than editing the tables above because
this file is under heavy concurrent-agent write contention right now
(repeated "modified since read" conflicts) — whoever next does a clean
pass should fold this into the top-level totals/negative-examples list and
re-derive via `python tools/corpus_stats.py`.

## Proposed update — combinatorics elementary packet (this agent, 2026-07-08)

Added `packets/elementary/combinatorics/card_union_add_card_inter.v1.json`:
the inclusion-exclusion identity `(s ∪ t).card + (s ∩ t).card = s.card +
t.card` over `Finset ℕ`, proved directly via `Finset.card_union_add_card_inter`.
Produced via tracked episode `23c3ba16-1c40-44bb-ad33-12dd9f01fe60`
(problem_version `6967d37a-6a76-4ad7-8fba-60ad72dc3f60`, dev-attested),
`kernel_verified` in a single `solve` step. Fills the exact gap the paired
negative example `packets/negative/combinatorics/finset_card_atoms_omega_failure.v1.json`
flagged (bare `omega` cannot derive this identity between the four
`Finset.card` atoms on its own). This is combinatorics' 34th elementary
packet (L0: 10, L1: 24) — appended here rather than editing the tables
above for the same concurrent-write-contention reason as the section
above. Schema-validated (`validate_packets.py --check-hashes
--warn-as-error`: 0 errors) and hash-stamped; also removed the now-filled
`card_union_add_card_inter` item from
`packets/elementary/combinatorics/QUEUE.md`.

## Proposed update — induction elementary packet (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/induction/bernoulli_inequality.v1.json`: `1 + n*x
<= (1+x)^n` for real `x >= -1`, proved by induction (successor step bridges
`ih` through `mul_le_mul_of_nonneg_right` and drops the nonnegative
`n*x^2` term via `sq_nonneg x`). Produced via tracked episode
`344364cb-791a-4e8a-9f5e-be0cc95210de` (problem_version
`b0ab294d-0ff8-4edd-9dd4-ef6e1a33f9da`, dev-attested), `kernel_verified` on
the first `solve` attempt. Uses `InequalityEstimateKit`
(cross-domain dependency recorded in
`packets/elementary/induction/CROSS_DOMAIN.md`) and closes the
`bernoulli_inequality` item from `packets/elementary/induction/QUEUE.md`.
This is induction's 8th packet overall (7th elementary + the
`two_pow_gt_self` negative example from the prior cycle this same session:
commit `9229fac`). Schema-validated (`validate_packets.py --check-hashes
--warn-as-error`: 0 errors) and hash-stamped;
`python tools/validate_packets.py packets/` reports 200 packets total,
0 errors, 0 warnings as of this update. Induction remains the smallest
elementary domain (8 packets vs. next-smallest at 16) — recommend it stay
top priority for elementary-gap work next cycle; remaining queue items are
`sum_evens`, `geom_series_sum_induction`, `factorial_ge_two_pow`.

## Proposed update — combinatorics elementary packet #2 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/disjoint_union_card.v1.json`: the
equality companion to `card_union_le.v1` — `Disjoint s t → (s ∪ t).card =
s.card + t.card` — proved via `(Finset.card_union_eq_card_add_card).mpr h`.
Produced via tracked episode `c0c34f8f-f08d-4b4c-a698-29d26328546b`
(problem_version `66bea032-57f0-4515-a941-fe1780a480c8`, dev-attested),
`kernel_verified` in a single `solve` step. This is combinatorics' 35th
elementary packet (L0: 10, L1: 25); closes the `disjoint_left` item from
`packets/elementary/combinatorics/QUEUE.md` and sets up the still-queued
"false without disjointness" negative-example candidate in
`packets/negative/combinatorics/QUEUE.md` (a genuinely unprovable goal, not
just a tactic mismatch — a different negative-example shape worth
preserving distinctly when authored). Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; full corpus revalidated clean at 203 packets, 0 errors, 0
warnings as of this update.

## Proposed update — combinatorics false_generalization negative example (this agent, 2026-07-08)

Added `packets/negative/combinatorics/card_union_no_disjoint_false_generalization.v1.json`
(combinatorics' 2nd negative example, 1st in the `false_generalization`
gap_category rather than `tactic_mismatch`) plus its companion
`packets/elementary/combinatorics/card_union_not_additive.v1.json` — a
kernel-verified disproof of the unconditional claim `(s ∪ t).card =
s.card + t.card` via the explicit witness s = t = {0}. Commit `246ca69`.
Same heavy-concurrency caveat as the note above: re-derive totals via
`python tools/corpus_stats.py` rather than trusting the tables above.

## Proposed update — induction elementary packet #2 (this agent, 2026-07-08, /loop continuation)

First attempted `bernoulli_inequality` independently (tracked episode
`6ab0d576-9b37-47b1-805e-285f617b11a6`, kernel_verified) but found another
domain-agent instance had already landed it (commit `48e808b`, episode
`344364cb...`) before this agent finished authoring — discarded rather
than duplicating the packet_id; the redundant episode is still a valid
tracked trajectory, just not turned into a packet.

Picked a different, less contended queue item instead: added
`packets/elementary/induction/factorial_ge_two_pow.v1.json` — `2 ^ n <=
(n + 1)!` for all `n`, equivalent via `n -> n - 1` to the queue's `n! >=
2^(n-1)` for `n >= 1` phrasing but restated shifted-by-one to avoid ℕ
truncated subtraction. Produced via tracked episode
`538ea8b6-6ad7-4a16-9e9b-bda5364ba942` (problem_version
`5f39c330-1179-41a7-90c9-106970f88386`, dev-attested,
`problem_imports: ["Mathlib.Data.Nat.Factorial.Basic",
"Mathlib.Tactic.Linarith"]`), `kernel_verified` on the first `solve`
attempt (`induction n with | zero => norm_num [Nat.factorial] | succ n ih
=> rw [Nat.factorial_succ, pow_succ]; nlinarith [ih, Nat.factorial_pos (n
+ 1)]`). Cross-referenced (not code-dependent) against
`packets/elementary/number_theory/factorial_pos.v1.json` /
`factorial_le.v1.json` in `packets/elementary/induction/CROSS_DOMAIN.md`;
closes the `factorial_ge_two_pow` item in
`packets/elementary/induction/QUEUE.md`. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; full corpus revalidated clean at 206 packets, 0 errors, 0
warnings as of this update (includes several other agents' concurrent
`sum_evens`, `card_union_not_additive`, `pigeonhole_3_into_2` additions).
Induction now has 10 elementary packets in the working tree (up from 7 at
the top of this cycle) — no longer the single most lopsided domain, but
still worth another pass before other elementary lanes.

## Proposed update — combinatorics elementary packet #3 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/pigeonhole_3_into_2.v1.json`: the
domain's first pigeonhole-principle packet, closing its largest documented
focus/content gap (`README.md` names "pigeonhole-style basics" explicitly;
zero packets covered it before this). States the concrete instance "3
items into 2 boxes forces a repeated box" as `∀ (f : ℕ → ℕ), (∀ a ∈
Finset.range 3, f a ∈ Finset.range 2) → ∃ x ∈ Finset.range 3, ∃ y ∈
Finset.range 3, x ≠ y ∧ f x = f y`, proved via
`Finset.exists_ne_map_eq_of_card_lt_of_maps_to` with the `2 < 3`
cardinality side-condition discharged by `decide`. Produced via tracked
episode `f2716b47-cc6b-4e6c-b791-1e153a4edf22` (problem_version
`d539d817-6d33-4960-bf2a-f95ecbfe9a5d`, dev-attested), `kernel_verified` on
the first `solve` attempt. Checked the working tree for a name collision
first (another concurrent agent's note above mentioned a
`pigeonhole_3_into_2` addition, but it was this same packet, already
present uncommitted when that agent wrote its note — no duplicate exists).
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 206 packets,
0 errors, 0 warnings as of this update. Remaining
`packets/elementary/combinatorics/QUEUE.md` next-targets: `card_powerset`,
`choose_zero_right`/`choose_self`/`choose_symm`.

## Proposed update — induction elementary packet: sum_evens (this agent, 2026-07-08, /loop continuation)

Landed `packets/elementary/induction/sum_evens.v1.json` independently
(before noticing another note above already flagged it as in-flight —
checked for a packet_id/file collision first, none found): `∑ i ∈
Finset.range n, (2*i+2) = n*(n+1)`, sum of the first n positive even
numbers 2, 4, ..., 2n, companion to `sum_odds`. Produced via tracked
episode `7c564d42-9a98-4780-9d1c-3affd65958d6` (problem_version
`beb3012b-98f4-496d-afb4-63f57f5c2d1b`, dev-attested), `kernel_verified`
on the first `solve` attempt (`induction n with | zero => simp | succ k
ih => rw [Finset.sum_range_succ, ih]; ring`).

Lesson worth keeping: two earlier `problem_create`/`episode_step`
attempts hit a statement-level `parse_error` at the `∈` token in `∑ i ∈
Finset.range n, ...`, identical regardless of proof_term (proving the
failure was in the *statement*, not the proof) — root cause: the default
dev-attestation import manifest (`Mathlib.Tactic.Ring` +
`Mathlib.Tactic.NormNum` only) doesn't carry `Finset.sum`/`∑` notation,
and `open scoped BigOperators` no longer resolves under this pinned
Mathlib rev (`unknown namespace BigOperators` — the notation is
unscoped/global now). Fix: pass `problem_imports:
["Mathlib.Algebra.BigOperators.Group.Finset.Basic"]` explicitly to
`problem_create` for any `Finset.sum`/`∑`-notation target authored via
`unsafe_dev_attestation`. Recorded in
`packets/elementary/induction/QUEUE.md`.

Also from earlier this session: `packets/negative/algebra/nat_sub_ring_trap.v1.json`
(algebra's 1st negative example, commit `49a7e23` — `ring` fails on a `ℕ`
truncated-subtraction cancellation because it ignores the ordering
hypothesis; `omega` closes it).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Same heavy-concurrency caveat as the notes
above: re-derive totals via `python tools/corpus_stats.py` rather than
trusting the top-level tables.

## Proposed update — functions elementary packet: injective_comp (this agent, 2026-07-08, /loop continuation)

Startup this cycle found: no bugs/triage items, every negative-example
domain lane already has >=1 packet (so priority-2's "zero coverage"
condition no longer applies anywhere), and `python tools/corpus_stats.py`
showed 198 verified public + 9 negative (207 files). Induction's own
`QUEUE.md` had only one open next-target (`geom_series_sum_induction`,
already in-flight uncommitted from another agent) plus a backlog item
explicitly gated on unauthored number_theory prerequisites — so, per
priority-3 ("furthest-behind domain"), moved to the next-smallest tier:
`inequalities` and `functions` tied at 16 packets each. Picked
`functions` because its `QUEUE.md` flags a real, explicit content gap:
all 16 existing packets are `abs`/`max`/`min` identities despite the
domain's stated README focus (injective/surjective/composition/inverse/
monotone/fixed-point basics) having zero packets.

Added `packets/elementary/functions/injective_comp.v1.json`: the
composition of two injective functions is injective, proved by directly
unfolding `Function.Injective` (`apply hf; apply hg; exact hab`) rather
than one-line-citing `Function.Injective.comp`, for instructional value.
Produced via tracked episode `ab41c15c-582d-481c-967c-c9daa8439bac`
(problem_version `574d8400-d226-480b-8965-1bdef6390eb6`, dev-attested),
`kernel_verified` on the second `solve` attempt — the first failed on a
binder-arity slip (root statement has three implicit type variables
`{α β γ}` that also need `intro`ing before the value/hypothesis args;
first attempt's `intro` list was three short). Not packaged as a
negative-example packet: a miscounted-binders slip isn't a tactic-mismatch
or automation hazard with independent training value the way the corpus's
existing `pow_succ`/`omega` negative examples are — recorded in the
packet's own `notes` field instead for trajectory honesty.

This is the first packet on `functions`' stated focus topics; closes the
`injective_comp` item in `packets/elementary/functions/QUEUE.md` (next up
per that queue: `surjective_comp`, pairs naturally). Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; full corpus revalidated clean at 208 packets, 0 errors, 0
warnings as of this update.

## Proposed update — combinatorics elementary packet #4 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/card_powerset.v1.json`: the
headline finite-combinatorics fact `(Finset.powerset s).card = 2 ^
s.card`, the domain's first packet to touch `powerset` at all. Proved
directly via `Finset.card_powerset`. Produced via tracked episode
`53929392-6942-40dd-a25f-69379262bf28` (problem_version
`1778104f-6306-4445-a0ce-ea3f875b144f`, dev-attested), `kernel_verified`
on the first `solve` attempt. Closes the `card_powerset` item in
`packets/elementary/combinatorics/QUEUE.md`; remaining next-target there
is `choose_zero_right`/`choose_self`/`choose_symm` (no `Nat.choose` packet
exists yet). Schema-validated (`validate_packets.py --check-hashes
--warn-as-error`: 0 errors) and hash-stamped; full corpus revalidated
clean at 209 packets, 0 errors, 0 warnings as of this update.
Combinatorics elementary now has 38 packets on disk (includes another
concurrent agent's `card_union_not_additive.v1.json`, commit `246ca69`,
not previously itemized in the domain DASHBOARD.md).
