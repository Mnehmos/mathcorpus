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

## Proposed update — inequalities elementary packet: am_gm_four_term (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; `python tools/corpus_stats.py` showed
200 verified public + 9 negative (209 files), all negative-example lanes
still >=1 (raw count 9/25 remains the biggest gap but "zero coverage" is
resolved everywhere). Direct file counts: induction 11 elementary packets
but its own `QUEUE.md` "Next targets" section is now empty (multiple
concurrent agents active there; remaining backlog item is gated on
unauthored number_theory prerequisites) — so, per priority-3, moved to the
next tier: `inequalities` (16) and `functions` (17, this agent's own prior
addition). Picked `inequalities`.

Added `packets/elementary/inequalities/am_gm_four_term.v1.json`:
`a^4+b^4+c^4+d^4 >= 4*a*b*c*d` for all reals — the radical-free polynomial
special case of four-term AM-GM (apply classical AM-GM to a^4,b^4,c^4,d^4),
holding for all reals, not just nonnegative ones, via the SOS identity
`a^4+b^4+c^4+d^4-4abcd = (a^2-b^2)^2+(c^2-d^2)^2+2(ab-cd)^2`. Produced via
tracked episode `26c22232-4518-4edc-9c11-b63813cf670f` (problem_version
`2a08df2e-2031-4d62-bb08-7123585f6a27`, dev-attested), `kernel_verified` on
the first `solve` attempt (`nlinarith [sq_nonneg (a^2 - b^2), sq_nonneg
(c^2 - d^2), sq_nonneg (a*b - c*d)]`). Deliberately avoided the classical
`(a+b+c+d)/4 >= (abcd)^(1/4)` radical form, which needs `Real.sqrt`/`rpow`
machinery beyond this cycle's scope. Completes the domain's AM-GM ladder
(`am_gm_two`, `three_var_am_gm`, now `am_gm_four_term`); closes the
`am_gm_four_term` item in `packets/elementary/inequalities/QUEUE.md`.

Schema-validated in isolation (`validate_packets.py --check-hashes
--warn-as-error packets/elementary/inequalities/am_gm_four_term.v1.json`:
0 errors) and hash-stamped. Note: a full-corpus validate run at the same
time showed 3 errors, all from another concurrent agent's in-flight,
unstamped `nesbitt_three_var.v1.json` / `nesbitt_bare_nlinarith_division_failure.v1.json`
(placeholder `0000...` hashes) — not this packet, not fixed here since
it's presumably that agent's own in-progress work; whoever lands those
should re-run `stamp_hashes.py` before committing. This agent's commit is
scoped to only its own files to avoid touching that in-flight work.

## Proposed update — inequalities elementary + negative pair: nesbitt_three_var (this agent, 2026-07-08, /loop continuation)

This agent (`packets/elementary/inequalities` scope) is the one whose
in-flight `nesbitt_three_var.v1.json` /
`nesbitt_bare_nlinarith_division_failure.v1.json` was flagged
unstamped by the note directly above — both are now stamped and
schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors each; full corpus re-validated clean at 213 packets, 0 errors, 0
warnings as of this update).

Startup this cycle found `bernoulli_inequality` already claimed and landed
by a concurrent agent on the `packets/elementary/induction/` side (commit
`48e808b`) — did not duplicate. Picked the next open item in
`packets/elementary/inequalities/QUEUE.md`: `nesbitt_three_var` — the
named olympiad inequality `a/(b+c)+b/(a+c)+c/(a+b) >= 3/2` for positive
`a, b, c` (D2, L2_olympiad). Confirmed no file/packet_id collision before
starting.

Added `packets/elementary/inequalities/nesbitt_three_var.v1.json`: proved
by clearing denominators (`div_add_div` twice, then `le_div_iff₀`) to
reach a polynomial goal, closed by `nlinarith` with the three
pairwise-difference square hints plus pairwise-product positivity facts.
Produced via tracked episode `f300e689-9670-45f4-8454-47e4e80b73ac`
(problem_version `7adeaf8c-df55-4be6-8ddd-68ffcd4b00fd`, dev-attested),
`kernel_verified` on the 4th `solve` attempt. The episode's earlier steps
are genuine, useful failures: step 1 (bare `nlinarith` on the raw division
goal, no denominator-clearing) kernel-failed and is preserved as
`packets/negative/inequalities/nesbitt_bare_nlinarith_division_failure.v1.json`;
step 2 hit the flattened-sequence inline-`by` parse trap (issue #67); step
3 used a stale lemma name (`le_div_iff` vs. this pinned Mathlib rev's
`le_div_iff₀`) — both recorded in the packets' own `notes` fields rather
than as separate negative examples (parse/lemma-name slips, not
independently reusable tactic-mismatch lessons the way the division-atom
failure is).

Closes the `nesbitt_three_var` item in
`packets/elementary/inequalities/QUEUE.md` (remaining next target:
`schur_degree_one`) and grows
`packets/negative/inequalities/` to 2 packets (up from the 1 this same
agent added last cycle). Inequalities elementary now has 18 packets on
disk (includes another concurrent agent's `am_gm_four_term.v1.json`).
Negative-example count corpus-wide is now approximately 10-11/25 (exact
count pending a fresh `python tools/corpus_stats.py` re-derive given
ongoing concurrent commits) — raw count remains the biggest gap versus the
v0.1 release criteria; every domain lane has had >=1 negative example for
several cycles now.

## Proposed update — algebra negative example (this agent, 2026-07-08)

Added `packets/negative/algebra/sq_sum_bare_nlinarith_missing_sos_hint.v1.json`
(algebra's 2nd negative example) plus companion
`packets/elementary/algebra/sq_sum_ge_two_mul.v1.json` (kernel-verified
`a^2 + b^2 >= 2ab` via `nlinarith [sq_nonneg (a - b)]`). Commit `6805462`.
Tooling note worth folding into a shared doc: `problem_create`'s default
import manifest (base Ring+NormNum only) does not include `nlinarith` or
real-number support — pass `problem_imports=["Mathlib"]` for any target
using `nlinarith`/`ℝ`, or it fails with an unrelated "unknown tactic"
error that looks like a proof-search lesson but isn't. Hit this twice now
(once for `Finset` last cycle, once for `nlinarith`/`ℝ` this cycle).

## Proposed update — induction elementary packet: sum_range_monotone (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; fresh `python tools/corpus_stats.py` +
per-folder recount showed 203 verified public + 10 negative (213 files),
every negative-example lane still >=1. Per-folder elementary counts:
induction 12 (still smallest — `sum_evens`, `bernoulli_inequality`,
`factorial_ge_two_pow`, `geom_series_sum_induction`, `exists_prime_factor`
all landed by concurrent agents since this session's earlier induction
cycle), functions 17, inequalities 18, geometry 29, combinatorics 38,
algebra 41, number_theory 48. Induction's own `QUEUE.md` "Next targets"
and "Backlog" sections were both empty (fully drained by concurrent
agents) but flagged two undemonstrated technique families from `LOOP.md`'s
domain focus: well-founded recursion via `SubmitModule`, and
monotonicity. Picked monotonicity as lower-risk for one cycle.

Added `packets/elementary/induction/sum_range_monotone.v1.json`: for
`f : ℕ → ℕ` and `n k : ℕ`, `(∑ i ∈ range n, f i) ≤ ∑ i ∈ range (n + k), f
i` — finite partial sums of a nonnegative-valued sequence are monotone in
the upper bound. Proved by induction on `k` (`Finset.sum_range_succ` +
`le_trans` + `Nat.le_add_right`), general-purpose and reusable as a
building block for future partial-sum/series comparison packets. Produced
via tracked episode `3280a193-bd9b-4189-a358-801911229181` (problem_version
`da2a7a4e-581c-46a9-9147-1a29c04a6ecc`, dev-attested,
`problem_imports: ["Mathlib.Algebra.BigOperators.Group.Finset.Basic"]`),
`kernel_verified` on the first `solve` attempt. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; commit `f8ffa2e`, scoped to only these two new files to
avoid touching other agents' in-flight work in this heavily-contended
domain. Recursion via `SubmitModule` remains this domain's one
undemonstrated technique family for a future cycle.

## Proposed update — combinatorics elementary packet #5 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/choose_zero_right.v1.json`:
`Nat.choose n 0 = 1`, the domain's first `Nat.choose` packet at all,
opening the roadmap's "finite combinatorics basics" binomial-coefficient
starter family. Proved directly via `Nat.choose_zero_right`. Produced via
tracked episode `dbba5471-27a3-4f88-938f-8006ecdc8a5c` (problem_version
`f74dbb40-2f04-4a1f-8be4-dac059057c46`, dev-attested,
`problem_imports: ["Mathlib.Data.Nat.Choose.Basic"]`), `kernel_verified`
on the first `solve` attempt. Narrowed the combined
`choose_zero_right`/`choose_self`/`choose_symm` QUEUE.md item into two
explicit remaining targets (`choose_self`, `choose_symm`) rather than
closing it outright, since only one of the three was done this cycle.
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 217 packets,
0 errors, 0 warnings as of this update.

## Proposed update — functions elementary packet: surjective_comp (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Direct file counts: induction 13
elementary packets (still smallest) but its own `QUEUE.md` "Next targets"
and "Backlog" sections are both explicitly empty right now (heavily
contended by other concurrent agents — `exists_prime_factor` and
`sum_range_monotone` both landed there this session already) — so, per
priority-3, moved to the next tier: `functions` (17 packets at the top of
this cycle). Picked up the paired item from the domain's own queue note
("pairs with `injective_comp`"): `surjective_comp`.

Added `packets/elementary/functions/surjective_comp.v1.json`: the
composition of two surjective functions is surjective, proved directly
(`obtain` a preimage from each surjectivity hypothesis in turn, then
`rw` through `Function.comp_apply`). Produced via tracked episode
`fd3f917e-f58b-4077-90da-bb1c3d62c203` (problem_version
`2a37daa0-ee1c-4014-97db-0e159855fe03`, dev-attested), `kernel_verified`
on the first `solve` attempt — applied the lesson from the paired
`injective_comp` packet's binder-arity slip and `intro`'d all three
implicit type variables up front this time. Closes the `surjective_comp`
item in `packets/elementary/functions/QUEUE.md`; next up there:
`linear_injective`, `strictMono_injective`, `id_bijective`,
`fixed_point_id`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this packet's own files
(packet JSON, Lean module, this domain's DASHBOARD.md/QUEUE.md, this
status section) to avoid touching other agents' concurrent in-flight work
elsewhere in the tree.

## Proposed update — induction elementary packet: even_odd_mutual_totality (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; fresh `python tools/corpus_stats.py`
showed 208 verified public + 11 negative (219 files). Per-folder recount:
induction 14 (still smallest), inequalities/functions 18 each, geometry
29, combinatorics 39, algebra 42, number_theory 48. Induction's `QUEUE.md`
"Backlog" (repopulated since my last cycle by another concurrent agent
after landing `exists_prime_factor` and a `SubmitModule` single-def
recursion demo, `myfactorial_eq_factorial`) explicitly flagged mutual
recursion via `mutual_group` as the one `SubmitModule` sub-feature still
undemonstrated.

Added `packets/elementary/induction/even_odd_mutual_totality.v1.json`:
defines `isEven`, `isOdd : ℕ → Bool` by mutual recursion
(`isEven 0 = true`, `isEven (k+1) = isOdd k`; `isOdd 0 = false`,
`isOdd (k+1) = isEven k`) via a `SubmitModule` `mutual_group`, and proves
every `n` is classified as even or odd (`isEven n = true ∨ isOdd n =
true`) by plain induction on `n` (unfold one mutual-recursion step via
`simp only [isEven, isOdd]`, close with `tauto` using the swapped-disjunct
`ih`). Produced via tracked episode
`11b1ffdb-ba62-4cfc-8791-51f371d4ef1d` (problem_version
`37507600-1b35-4525-b6ce-f10a2cdd47c5`, dev-attested), `kernel_verified`
on the first `submit_module` attempt. Closes the induction `QUEUE.md`
backlog's "mutual recursion" candidate; the domain has now exercised every
`SubmitModule` sub-feature its `LOOP.md` focus list names except
well-founded (non-structural, `termination_by`-style) recursion.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `824410b`, scoped to only these two new
files. Full `packets/elementary/induction/` revalidated clean at 16
packets, 0 errors, 0 warnings as of this update (includes other agents'
concurrent additions since the count above).

## Proposed update — induction elementary packet, negative example pivot (this agent, 2026-07-08)

Attempted the queued induction negative example ("induction without
generalizing an auxiliary variable" -- foldl/reverse accumulator lemma
proved by `induction l` with `acc` fixed). The natural-but-wrong attempt
actually kernel-verified (`simp [ih]` bridges the accumulator shift on its
own), so per the domain's own queue policy this was authored as a positive
packet instead: `packets/elementary/induction/foldl_cons_eq_reverse_append.v1.json`
(commit `5c61d06`). Corrected `packets/negative/induction/QUEUE.md` to
suggest a weaker closing tactic (`rfl`/bare `exact ih`) for a genuine
future attempt at this failure mode. Also hit a proof-transport snag along
the way: a multi-line `induction l with | ... => ... | ... => ...` block
under `proof_format: raw_lean_block` mis-parsed; putting the whole
`with |...|...`  case-split on one line under the default
`flat_tactic_sequence` format worked.

## Proposed update — combinatorics elementary packet #6 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/choose_self.v1.json`: `Nat.choose
n n = 1`, companion to the previously-added `choose_zero_right'`. Proved
directly via `Nat.choose_self`. Produced via tracked episode
`0f2f545b-6a3f-454d-949a-8ce95c042cb0` (problem_version
`5f135de9-4be8-4157-9926-41ba2b7335e5`, dev-attested,
`problem_imports: ["Mathlib.Data.Nat.Choose.Basic"]`), `kernel_verified`
on the first `solve` attempt. Closes the `choose_self` item in
`packets/elementary/combinatorics/QUEUE.md`; remaining next-target there
is `choose_symm`. Schema-validated (`validate_packets.py --check-hashes
--warn-as-error`: 0 errors) and hash-stamped; full corpus revalidated
clean at 222 packets, 0 errors, 0 warnings as of this update.

## Proposed update — inequalities elementary packet: schur_degree_one (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Direct file counts: induction still
smallest (16) but its `QUEUE.md` "Next targets" is empty again (very
heavily contended — `even_odd_mutual_totality`, `myfactorial_eq_factorial`,
`foldl_cons_eq_reverse_append` all landed there this session); next
furthest-behind tier was `inequalities`/`functions` tied at 18. Picked
`inequalities` this time (previously did two `functions` packets back to
back) and took the one open item: `schur_degree_one`.

Added `packets/elementary/inequalities/schur_degree_one.v1.json`: Schur's
inequality (t=1) for nonnegative reals,
`a(a-b)(a-c)+b(b-a)(b-c)+c(c-a)(c-b) >= 0`. Schur is degree 3 (odd), so
unlike this cycle's earlier `am_gm_four_term` it is *not* a pure
sum-of-squares and has no single global nlinarith certificate — proved via
an 8-way ordering case split (`rcases le_total a b <;> rcases le_total b c
<;> rcases le_total a c`) closed uniformly by one `nlinarith` call given a
shared set of `mul_nonneg`/`sq_nonneg` product hints covering every
branch's needed certificate. Produced via tracked episode
`cbffe931-b879-4d09-b98e-1394e26a4e30` (problem_version
`afccea21-2ce5-4049-bc4e-68ef453217c0`, dev-attested), `kernel_verified`
on the first `solve` attempt — the case-split-then-uniform-nlinarith
pattern worked without needing per-branch tactics. Pairs with
`nesbitt_three_var`; closes the `schur_degree_one` item in
`packets/elementary/inequalities/QUEUE.md` (now empty of next-targets,
only the AM-GM-general-n backlog item remains).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this packet's own files
to avoid touching other agents' concurrent in-flight work elsewhere in
the tree.
