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

## Proposed update — geometry elementary + negative pair: pythagorean_right_angle (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. `python tools/corpus_stats.py` showed
211 verified public + 11 negative (222 files). Checked
`packets/elementary/inequalities/QUEUE.md` first (this agent's usual
scope) — found its own prior `nesbitt_three_var` target's follow-up,
`schur_degree_one`, already claimed and landed by another concurrent agent
(commit visible in this file's section immediately above), and
"Next targets" now empty there. Per priority-3 (furthest-behind domain),
re-derived folder-level packet counts directly (the domain-field-based
table above conflates `algebra`/`inequalities`/`induction`, all of which
use `domain: "algebra"`): geometry had 29 packets on disk, the smallest
folder at that moment (induction had already grown to 16 from concurrent
agents this session). Picked geometry's `pythagorean_right_angle` — an
explicitly flagged "curriculum-notable gap" in
`packets/elementary/geometry/QUEUE.md` (the domain had `dist_sq_expand`,
`distance_sq_nonneg`, `triangle_angle_sum` but no Pythagorean-theorem
packet). Confirmed no file/packet_id collision before starting.

Added `packets/elementary/geometry/pythagorean_right_angle.v1.json`: in
this domain's coordinate-pair convention (points as plain `x_i y_i : ℝ`,
not `EuclideanSpace`/`dist`), states that a right angle at B (dot product
of (A-B) and (C-B) is zero) implies squared-distance(A,C) =
squared-distance(A,B) + squared-distance(B,C). Produced via tracked
episode `1ee45ae1-bde1-4cfa-bd4a-68261f9f8fb1` (problem_version
`e220c871-1bc0-4699-bdf0-f7cd2b8b145a`, dev-attested), `kernel_verified` on
the 2nd `solve` attempt (`nlinarith [h]`). Step 1, a bare `ring` attempt,
genuinely kernel-failed with an `unsolved_goals` residual — `ring` only
proves unconditional polynomial identities and never consults hypotheses,
so it cannot use the right-angle condition `h` that makes this particular
identity true. Preserved as
`packets/negative/geometry/pythagorean_bare_ring_no_hypothesis_failure.v1.json`
— a genuinely new `sub_category` (`ring_on_hypothesis_dependent_goal`) for
this domain's negative-example lane, distinct from its existing
`nlinarith`-timeout-on-angle-atoms example.

Closes the `pythagorean_right_angle` item in
`packets/elementary/geometry/QUEUE.md` (remaining next targets:
`circle_point_dist_eq_radius`, `right_triangle_area_half_base_height`,
`reflection_over_x_axis`); grows
`packets/negative/geometry/` to 2 packets. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors each) and
hash-stamped; full corpus revalidated clean at 225 packets, 0 errors, 0
warnings as of this update (213 verified public + 12 negative per
`corpus_stats.py`, 85.2% of the 250-packet v0.1 public target, 12/25
negative examples). Commit scoped to only this cycle's own files.

## Proposed update — combinatorics elementary packet #7 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/choose_symm.v1.json`: binomial
coefficient symmetry `Nat.choose n k = Nat.choose n (n - k)` for `k <= n`,
proved via `(Nat.choose_symm hk).symm`. Produced via tracked episode
`2478c40d-0003-42ae-a1b9-343a7f150531` (problem_version
`26a83d9a-f852-4a47-a507-9d32ce614995`, dev-attested,
`problem_imports: ["Mathlib.Data.Nat.Choose.Basic"]`), `kernel_verified`
on the first `solve` attempt. This completes the roadmap's `Nat.choose`
starter family (`choose_zero_right'`/`choose_self'`/`choose_symm'`), all
three added across this agent's last three cycles. Promoted
`card_image_le` from backlog to `packets/elementary/combinatorics/QUEUE.md`
next-targets and added a new `choose_succ_succ` (Pascal's rule) candidate
now that the basics family is done. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; full corpus revalidated clean at 227 packets, 0 errors, 0
warnings as of this update. Commit scoped to only this cycle's own files
(another agent has induction files staged concurrently).

## Proposed update — functions elementary packet: strictmono_injective (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; fresh `python tools/corpus_stats.py`
showed 213 verified public + 12 negative (225 files, 85.2% of the v0.1
public target). Per-folder recount: induction 16 (still smallest, but its
own `QUEUE.md` "Next targets" and "Backlog" are both explicitly empty —
every focus-list technique from `LOOP.md` is now demonstrated, including
mutual recursion via `even_odd_mutual_totality` from this agent's prior
cycle). Moved to the next tier: `functions` (18) and `inequalities` (19).
Picked `functions` — its `QUEUE.md` still names four open items
(`linear_injective`, `strictMono_injective`, `id_bijective`,
`fixed_point_id`) on the domain's stated focus.

Added `packets/elementary/functions/strictmono_injective.v1.json`: for
`α` linearly ordered, `β` preordered, `f : α → β`, `StrictMono f →
Function.Injective f`, proved directly via `lt_trichotomy` (not citing
Mathlib's `StrictMono.injective`, for instructional value — mirrors the
`injective_comp` packet's choice). Produced via tracked episode
`aef62b6e-d395-4b6e-83f1-35f2019a8851` (problem_version
`c3c85dbe-b075-489a-8b6c-c238230c5dfb`, dev-attested), `kernel_verified`
on the first `solve` attempt. Closes the `strictMono_injective` item in
`packets/elementary/functions/QUEUE.md` — explicitly connects the domain's
"monotone" and "injective" stated focus topics for the first time.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `5688a4c`, scoped to only these two new
files (another concurrent agent has `linear_injective` staged
uncommitted). Full `packets/elementary/functions/` revalidated clean at 20
packets, 0 errors, 0 warnings as of this update.

## Proposed update — functions elementary packet: id_bijective (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Went to pick up `strictMono_injective`
from `packets/elementary/functions/QUEUE.md` (induction, still smallest,
had an empty queue again) and proved it independently via tracked episode
`a87d8f34-baef-4887-b0b6-ec74909fee9a` (`kernel_verified` on the first
attempt: `lt_trichotomy` case split, `(hf h).ne` in the two strict cases)
— but on checking the working tree before authoring, found another
concurrent agent had already landed both `strictMono_injective` (commit
`5688a4c`, episode `aef62b6e...`) and `linear_injective` (staged
uncommitted) from the same queue. Discarded the redundant packet-authoring
step (the tracked episode itself is still valid data, just unused) and
picked the one remaining open item instead: `id_bijective`.

Added `packets/elementary/functions/id_bijective.v1.json`: the identity
function is bijective, for every type `α`. Produced via tracked episode
`7bce298c-c66f-4696-a952-c7f82691c46a` (problem_version
`6c3f11cb-da21-44fe-b6de-13700b4a6d7d`, dev-attested), `kernel_verified` on
the second `solve` attempt — the first used a bulleted `constructor;
· ...; · ...` tactic proof that lost its case-block structure under the
default `flat_tactic_sequence` transport (diagnostic: `hab` bound by the
first case's `intro` was reported "Unknown identifier" in what should have
been the same bullet — a transport hazard distinct from the `injective_comp`
binder-arity slip and the `raw_lean_block`/`show` issue noted elsewhere in
this domain's cycles); fixed by switching to a single-line, bullet-free
term-mode proof (`exact ⟨fun a b hab => hab, fun b => ⟨b, rfl⟩⟩`). Not
packaged as a separate negative example (an authoring/transport slip, not
an independent tactic-mismatch lesson) — recorded in the packet's own
`notes` instead. Closes the `id_bijective` item in
`packets/elementary/functions/QUEUE.md`; only `fixed_point_id` remains
open there (`linear_injective`/`strictMono_injective` marked with
git-log-check notes to prevent a third agent re-duplicating them).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this packet's own files
to avoid touching `linear_injective` (still another agent's uncommitted
work) or any other concurrent in-flight change.

## Proposed update — functions negative example + naming-collision avoidance (this agent, 2026-07-08)

Added `packets/negative/functions/quad_injective_simp_unfold_incomplete.v1.json`
(functions' 2nd negative example: `simp [Function.Injective]` leaves a
quadratic goal open) plus companion positive packet
`packets/elementary/functions/linear_injective_concrete_instance.v1.json`
(same bare tactic kernel-verifies on a linear instance). Commit `e5d29ce`.
Deliberately renamed the positive packet away from the `linear_injective`
packet_id that `packets/elementary/functions/QUEUE.md` reserves for the
general `f x = a*x+b, a != 0` lemma, to avoid colliding with another
concurrent agent noted as already working that queue item — worth a
general callout: check queue files for "another agent appears to be
working this" notes before claiming a packet_id, and prefer a more
specific name for a narrower/concrete variant of a queued general lemma.

## Proposed update — combinatorics elementary packet #8 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/card_image_le.v1.json`:
`(s.image f).card <= s.card` — the image of a finite set under a function
has at most as many elements as the original set. Proved directly via
`Finset.card_image_le`. Produced via tracked episode
`56d41a21-a9b7-419f-828c-7fd4658197d1` (problem_version
`1f2d5565-941c-4819-8211-88bc6ce197fb`, dev-attested), `kernel_verified`
on the first `solve` attempt. Closes the `card_image_le` item (promoted
from backlog last cycle) in `packets/elementary/combinatorics/QUEUE.md`;
remaining next-target there is `choose_succ_succ` (Pascal's rule).
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 232 packets,
0 errors, 0 warnings as of this update.

## Proposed update — geometry elementary packet: circle_point_dist_eq_radius (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Direct file counts: induction (17)
and inequalities (19) both had genuinely empty `QUEUE.md` "Next targets"
(and empty/backlog-only Backlog) — every focus-list item repeatedly gets
claimed by concurrent agents faster than a fresh cycle can act on it. Per
priority-3, moved to the next tier: `geometry` (30), which still had open
queue items.

Added `packets/elementary/geometry/circle_point_dist_eq_radius.v1.json`:
the cosine/sine parametrization `(cx + r*cos θ, cy + r*sin θ)` has squared
distance `r^2` from the center `(cx, cy)`, for every angle `θ`. This
domain's first circle-equation packet at all. Produced via tracked episode
`d3dedd8a-5919-404f-baf4-3952a49bb159` (problem_version
`c89c25e3-76d3-457d-8e06-82bded241297`, dev-attested,
`problem_imports: ["Mathlib.Analysis.Complex.Trigonometric"]` for
`Real.sin_sq_add_cos_sq`), `kernel_verified` on the first `solve` attempt
(`have h := Real.sin_sq_add_cos_sq θ; nlinarith [h]`). Deliberately
phrased with squared distance rather than the queue's literal
`dist p c = r` wording, to stay consistent with this domain's existing
convention of avoiding `Real.sqrt` (`midpoint_equidist`, `reflection_dist`
do the same) while still proving something genuinely circle-shaped rather
than restating the defining equation on a single point. Closes the
`circle_point_dist_eq_radius` item in
`packets/elementary/geometry/QUEUE.md`; remaining next-targets there:
`right_triangle_area_half_base_height`, `reflection_over_x_axis`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this packet's own files
to avoid touching other agents' concurrent in-flight work elsewhere in
the tree.

## Proposed update — functions elementary packet: linear_injective (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; fresh `python tools/corpus_stats.py`
showed 220 verified public + 13 negative (233 files, 88.0% of the v0.1
public target, 30 to go). Induction's `QUEUE.md` was fully drained again
(`fib_le_two_pow` landed since my last cycle — every `LOOP.md` focus
technique now demonstrated); inequalities' `QUEUE.md` also fully drained
(only a deferred L2/L3 general-AM-GM backlog item remains). Moved to
`functions` (21 packets), whose `QUEUE.md` still named `linear_injective`
(general `a ≠ 0` form — distinct from the already-landed
`linear_injective_concrete_instance`) and `fixed_point_id` as open.

Added `packets/elementary/functions/linear_injective.v1.json`: for real
`a, b` with `a ≠ 0`, `f(x) = a*x + b` is injective (`linarith` cancels the
additive constant, `mul_left_cancel₀` cancels the nonzero slope). Produced
via tracked episode `ea9a41a4-dbe0-4f97-9a10-d703cd75bb8d`
(problem_version `8b2e8c7c-7aa3-48df-99bf-527209c6bbb3`, dev-attested),
`kernel_verified` on the first accepted attempt.

Tooling lesson worth flagging broadly: two earlier `problem_version`s of
this exact target **timed out** ("Lean invocation timed out after 60
seconds") using `problem_imports: ["Mathlib"]` — deterministically, twice,
regardless of `proof_term` — likely load-related given how many concurrent
agents are hitting this environment right now. A `["Mathlib.Tactic.Linarith"]`-only
import elaborated fast but failed with missing real-number typeclass
instances (`OfNat ℝ 0`, `HMul ℝ ℝ`), since a tactic import alone doesn't
pull in the real-number algebraic structure. The combination that worked:
`["Mathlib.Data.Real.Basic", "Mathlib.Tactic.Linarith"]` — narrow and
fast. Recommend other agents prefer narrow, targeted `problem_imports`
over the blanket `["Mathlib"]` for real-number targets, reserving the full
import only when a narrow set can't be identified — this may also explain
some of the "unrelated unknown tactic" timeouts other agents attributed to
missing imports in earlier cycles' notes above.

Closes the `linear_injective` item in `packets/elementary/functions/QUEUE.md`.
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `8bdeb46`, scoped to only these two new
files. Full `packets/elementary/functions/` revalidated clean at 22
packets, 0 errors, 0 warnings as of this update.

## Proposed update — induction negative example, take 2 resolved (this agent, 2026-07-08)

Added `packets/negative/induction/foldl_no_generalize_ih_too_weak.v1.json`
(induction's 2nd negative example): closing the `cons` case of the
foldl/reverse accumulator induction with bare `exact ih` (instead of
`simp [ih]`) fails with a clean type mismatch, confirming the classic
"induction without generalizing" trap the domain's queue had flagged as
disproven at take 1. Commit `95afb50`. Reused the same `problem_version_id`
across both episodes (same root statement, different closing tactic) --
worth noting as a pattern: when a "wrong tactic" hypothesis surprises you
by succeeding, don't necessarily abandon the target — a weaker/different
closing tactic on the *same* problem_version can still yield the intended
negative example without re-registering the problem.

## Proposed update — geometry elementary packet: reflection_over_x_axis (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Checked `packets/elementary/inequalities/QUEUE.md` (usual scope) first — empty of next-targets (`schur_degree_one` already landed by a concurrent agent). Checked `packets/elementary/induction/QUEUE.md` next (folder-count smallest at 18) — also empty, explicitly noting heavy concurrent contention there. Picked geometry (31 packets, this agent's prior cycle's domain) and took its next open item, `reflection_over_x_axis`, after confirming no collision.

Added `packets/elementary/geometry/reflection_over_x_axis.v1.json`: coordinate reflection `(x,y) -> (x,-y)` preserves squared distance to any point `(qx, 0)` on the x-axis, closed by `ring` (an unconditional polynomial identity once the axis point's y-coordinate is fixed at 0 in the statement itself). Produced via tracked episode `66dcb53d-d77c-4467-ad54-bdf0db0008a6` (problem_version `1b78aaec-8370-40fc-8423-9cad5b108acd`, dev-attested), `kernel_verified` on the first real attempt. A first `problem_create` omitting an explicit `problem_imports: ["Mathlib"]` resolved to a bare Ring+NormNum manifest and hit a spurious `HSub ℝ ℝ ?m` typeclass-resolution failure on the identical `ring` tactic — diagnosed as a tooling/import-manifest artifact (not a genuine tactic-mismatch lesson, since it's purely about which Mathlib modules got registered, not about the proof strategy), so not packaged as a negative example, consistent with how this repo has treated similar import-manifest gotchas elsewhere. Re-registering with the standard `["Mathlib"]` import manifest (hash `aaf21893d520a78dee0787a1bcaf939ee6b922265ff670c272e2e1d450dd29a7`, matching every other packet in this repo) resolved it.

Closes the `reflection_over_x_axis` item in `packets/elementary/geometry/QUEUE.md` (remaining next target: `right_triangle_area_half_base_height`). Schema-validated (`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and hash-stamped; full corpus revalidated clean at 237 packets, 0 errors, 0 warnings as of this update (223 verified public + 14 negative per `corpus_stats.py`, 89.2% of the 250-packet v0.1 public target, 14/25 negative examples). Commit scoped to only this cycle's own files.

## Proposed update — combinatorics elementary packet #9 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/choose_succ_succ.v1.json`:
Pascal's rule `Nat.choose (n+1) (k+1) = Nat.choose n k + Nat.choose n
(k+1)`, proved directly via `Nat.choose_succ_succ'`. Produced via tracked
episode `53ff8716-d93a-45df-a9e9-9ab544112cce` (problem_version
`acde07d0-be48-47a3-b7eb-be2f4ad1ffca`, dev-attested), `kernel_verified`
on the first `solve` attempt. Closes the `choose_succ_succ` item in
`packets/elementary/combinatorics/QUEUE.md`; promoted the
binomial-coefficient-sum identity from backlog to next-targets (now that
Pascal's rule is available as a building block) and added a new
`card_biUnion`/indexed-union candidate (verified `Finset.card_biUnion`
exists in Mathlib before queuing it). Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; full corpus revalidated clean at 238 packets, 0 errors, 0
warnings as of this update.

## Proposed update — induction elementary packet: fib_sum_succ (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Direct file counts: induction (18,
still smallest) and inequalities (19) both had `QUEUE.md` "Next targets"
and "Backlog" completely empty again — this keeps recurring because
several concurrent agents are hammering the same two small domains every
cycle. Rather than default further down to a larger domain, repopulated a
target directly from induction's own `LOOP.md` domain-specific focus list
(finite sums/products, recurrence relations) since that list explicitly
licenses this when the queue file is dry.

Added `packets/elementary/induction/fib_sum_succ.v1.json`: the Fibonacci
partial-sum identity `(∑_{i<n} fib i) + 1 = fib(n+1)`, using Mathlib's
`Nat.fib` directly (phrased additively, not `sum = fib(n+1) - 1`, to avoid
ℕ truncated subtraction — same convention this domain has used
repeatedly, e.g. `sum_evens`). Distinct from the already-authored
`fib_le_two_pow` (a growth-rate *bound* on a hand-rolled `SubmitModule`
fib): this is an exact identity on the real `Nat.fib`. Produced via
tracked episode `fe47cf48-95d4-4fbc-a25a-7b089b11b0e6` (problem_version
`4250e33d-ccec-494b-8676-d781e1e09f9a`, dev-attested,
`problem_imports: ["Mathlib.Algebra.BigOperators.Group.Finset.Basic",
"Mathlib.Data.Nat.Fib.Basic"]`), `kernel_verified` on the first `solve`
attempt (`Finset.sum_range_succ` to peel the last term, `Nat.fib_add_two`
to rewrite the target's `fib(k+2)`, then `omega` closes the resulting
linear rearrangement over the sum/fib atoms using the induction
hypothesis already in context).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this packet's own files
to avoid touching other agents' concurrent in-flight work.

## Proposed update — functions elementary packet: monotone_comp (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; fresh `python tools/corpus_stats.py`
showed 226 verified public + 14 negative (240 files, 90.4% of the v0.1
public target, 24 to go). Every negative-example domain lane now sits at
exactly 2 (14/25 total) — raw count is the only remaining gap there, no
domain has zero. Per this agent's literal priority order (bugs > zero-
coverage negative examples > furthest-behind elementary domain >
frontier), zero-coverage is fully resolved everywhere, so continued with
elementary curriculum: induction's `QUEUE.md` (19 packets) was fully
drained again (`prod_range_monotone`, `fib_sum_succ` landed since my last
cycle); inequalities' `QUEUE.md` (20) also fully drained (only the
deferred L2/L3 general-AM-GM item remains). Moved to `functions` (22),
whose `QUEUE.md` backlog still named `monotone_comp` (composition of
monotone functions) as open.

Added `packets/elementary/functions/monotone_comp.v1.json`: for preordered
`α, β, γ`, `f : α → β` and `g : β → γ` both monotone implies `g ∘ f` is
monotone (`intro a b hab; exact hg (hf hab)`). Produced via tracked
episode `c8b140d2-d2e3-4791-8237-0fa8c0f6d29d` (problem_version
`8e96fdae-9053-49ea-80e0-936833b8d9b8`, dev-attested), `kernel_verified`
on the first attempt — no import trouble this time (`Preorder`/`Monotone`
resolve under the base Ring+NormNum manifest, unlike the real-number
targets from two cycles ago). Completes the composition trio
(`injective_comp`, `surjective_comp`, `monotone_comp`); closes the
`monotone_comp` backlog item in `packets/elementary/functions/QUEUE.md`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `1b82ee3`, scoped to only these two new
files. Full `packets/elementary/functions/` revalidated clean at 23
packets, 0 errors, 0 warnings as of this update. Remaining open item in
that domain's `QUEUE.md`: `fixed_point_id`; remaining backlog: a concrete
image/preimage identity.

## Proposed update — combinatorics elementary packet #10 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/sum_range_choose.v1.json`: `∑ m ∈
range (n+1), Nat.choose n m = 2 ^ n` — the sum of a row of Pascal's
triangle is a power of two, tying the domain's `Nat.choose` starter family
back to `card_powerset'` (both land on `2 ^ n`). Proved directly via
`Nat.sum_range_choose`. Produced via tracked episode
`11038106-d316-457e-bda5-e2aa5ac19417` (problem_version
`2e61a937-60e2-44b4-b16f-06b05d091861`, dev-attested,
`problem_imports: ["Mathlib.Data.Nat.Choose.Sum"]`), `kernel_verified` on
the first `solve` attempt. Closes the binomial-coefficient-sum item in
`packets/elementary/combinatorics/QUEUE.md`; remaining next-target there
is `card_biUnion`/indexed-union basics. Also condensed this domain's
`DASHBOARD.md` per-packet bullet list (10 entries added across this
session) into a summary paragraph — it was growing unbounded; full detail
remains in each packet's own `verification.episode_id` and in `git log`.
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 242 packets,
0 errors, 0 warnings as of this update.

## Proposed update — number_theory negative example (this agent, 2026-07-08)

Added `packets/negative/number_theory/gcd_dvd_omega_no_gcd_theory.v1.json`
(number_theory's 3rd negative example): `omega` fails on `Nat.gcd a b | a`
with zero theory of `Nat.gcd` at all. Commit `7e9377f`. Note: the repair
step's theorem (`Nat.gcd_dvd_left a b`) already existed in the corpus as
`elementary.number_theory.gcd_dvd_left.v1` -- checked before authoring and
skipped the duplicate positive packet, referencing the existing one
instead. Worth flagging as a reusable check: before authoring a companion
positive packet, grep `packets/elementary/<domain>/*.json` for the target
statement/theorem name first.

## Proposed update — inequalities elementary packet: abs_add_three (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Induction (19) and inequalities (20)
both had empty queues again — recurring pattern, several concurrent
agents draining these two small domains every cycle faster than any
single cycle can refill them. Picked `inequalities` and extended the
recently-added `abs_add_le` to three terms, continuing the effort to
offset this domain's L0/L2 skew.

Added `packets/elementary/inequalities/abs_add_three.v1.json`:
`|a+b+c| <= |a|+|b|+|c|`. First attempt cited a nonexistent `abs_add`
lemma name (`Unknown identifier`) — switched to the `abs_cases`-based
16-branch case split (`a`, `b`, `c`, `a+b+c`) the paired `abs_add_le`
packet already uses, closed uniformly by `nlinarith`; `kernel_verified`
on that second attempt. Episode: `00c6c1c7-af24-448f-bb93-1e1944e1791a`.

**Tool bug encountered and worked around** (logged in
`agents/github_issues/BUGS.md`): after an `episode_step` with a wrong
`expected_revision` returned `stale_revision`, `episode_observe` — the
documented recovery call — itself threw `UNIQUE constraint failed:
action_requests.episode_id, action_requests.episode_revision` on two
separate retries, leaving the claim stuck. Workaround: skip
`episode_observe` and re-call `attempt_claim` with the *same*
`idempotency_key` as the original claim; this revived it per the tool's
documented idempotent-claim-recovery behavior, and the next `episode_step`
with the correct `expected_revision` went through normally. Worth the
dev-loop agent's attention if it recurs.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this packet's own files
plus the `BUGS.md` entry.

## Proposed update — inequalities negative example: bare linarith on a nonlinear goal (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no new bugs beyond the already-logged `episode_observe`
UNIQUE-constraint issue (has a documented workaround, out of scope for a
repo-tooling fix per `LOOP.md` priority-1's schema/hash/export/redaction
framing — proofsearch MCP internals aren't this repo's code). Checked
`packets/elementary/inequalities/QUEUE.md` and
`packets/elementary/induction/QUEUE.md` (folder counts: induction 19,
inequalities 21 — both smallest) — both fully saturated (empty
next-targets/backlog) from heavy concurrent-agent activity this session.
Per-domain negative-example counts were also already even (every domain at
2, `number_theory` at 3) — no zero-coverage gap to fill. Picked the
remaining open item in `packets/negative/inequalities/QUEUE.md`: bare
`linarith` (not `nlinarith`) on a nonlinear goal, a "wrong tactic
entirely" failure class distinct from this lane's existing "right tactic,
missing hints" examples.

Added `packets/negative/inequalities/two_mul_le_add_sq_bare_linarith_failure.v1.json`:
reused the exact statement from the existing positive packet
`packets/elementary/inequalities/two_mul_le_add_sq.v1.json` (`2*a*b <=
a^2+b^2`) in a fresh, independent tracked episode
`8cbd4eff-8a4a-4c80-b0bb-49cfa0c7e181` (problem_version
`bf87bc24-926d-4f85-a3f7-adbb1c8f41f3`, dev-attested). Step 1, bare
`linarith`, genuinely `kernel_fail`'d ("linarith failed to find a
contradiction") since `linarith` never multiplies hypotheses or considers
squares at all — categorically the wrong tool for any goal with a product
or square of two variables, not merely under-hinted. Step 2, `nlinarith
[sq_nonneg (a - b)]`, closed the same episode `kernel_verified`
immediately.

No new positive packet authored this cycle (the statement already has one);
this is a standalone negative-example addition, which the roadmap's raw
negative-example count (now 16/25) still needs regardless of per-domain
coverage. Schema-validated (`validate_packets.py --check-hashes
--warn-as-error`: 0 errors) and hash-stamped; full corpus revalidated clean
at 245 packets, 0 errors, 0 warnings as of this update (229 verified public
+ 16 negative per `corpus_stats.py`, 91.6% of the 250-packet v0.1 public
target). Commit scoped to only this cycle's own files.

## Proposed update — combinatorics elementary packet #11 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/card_bi_union_le.v1.json`:
`(s.biUnion t).card <= ∑ i ∈ s, (t i).card` — the indexed-union
generalization of the domain's existing `card_union_le'`. Proved directly
via `Finset.card_biUnion_le`. Produced via tracked episode
`e3c5ed4b-c31c-4b90-8598-5e18ac5575b3` (problem_version
`6196c767-a884-4f69-bc31-bc9b1e1cdc38`, dev-attested,
`problem_imports: ["Mathlib.Algebra.BigOperators.Group.Finset.Basic"]`),
`kernel_verified` on the first `solve` attempt. This closed the last item
in `packets/elementary/combinatorics/QUEUE.md`'s next-targets, so also
added two fresh candidates: `card_sdiff_of_subset` (set-difference
cardinality — verified the Mathlib lemma exists first) and a general
(non-concrete) pigeonhole statement generalizing `pigeonhole_3_into_2`.
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 247 packets,
0 errors, 0 warnings as of this update. This is this agent's 11th
combinatorics elementary packet added across this session's /loop cycles.

## Proposed update — induction elementary packet: mygcd_wellfounded (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage requiring in-repo action (a new
`agents/github_issues/BUGS.md` entry describes an intermittent
`episode_observe` UNIQUE-constraint error in the **proofsearch MCP
server** itself — a separate repo/binary
(`mnehmos.llm-driven-proof-search.environment`), not this repo's
`tools/*.py`/schema, and already has a documented working workaround, so
out of scope for this domain-agent role per `agents/github_issues/LOOP.md`
§startup routine's own tools/-scoped bug list). Fresh
`python tools/corpus_stats.py` showed 231 verified public + 16 negative
(247 files, 92.4% of the v0.1 public target, 19 to go); every
negative-example lane at >=2. Induction (19 packets) still smallest; its
`QUEUE.md` had exactly one open item left — the backlog's explicitly
flagged, explicitly risky "well-founded (non-structural) recursion via
`SubmitModule`" gap, deferred by a prior cycle with a note that a future
cycle should budget for a few failed tries or a negative-example fallback.
Took that budget this cycle.

Added `packets/elementary/induction/mygcd_wellfounded.v1.json`: defines
`myGcd` (Euclidean algorithm) via `Nat.strongRecOn`, decreasing on the
second argument via `Nat.mod_lt` (`a % (b+1) < b+1`) — genuinely
well-founded, not structural. Proves the base case `myGcd a 0 = a` via
`simp [myGcd, Nat.strongRecOn_eq]`. Produced via tracked episode
`7e36dbd3-c071-4200-8fb3-17e84713e94e` (problem_version
`1f792d1c-bbd8-4f66-b16e-9c38584bc181`, dev-attested), `kernel_verified`
on the **third** `submit_module` attempt. Two genuinely informative
failures preserved in the packet's `notes`: (1) ordinary equation-compiler
pattern syntax for `myGcd` kernel-failed with "Could not find a
decreasing measure. Please use `termination_by`" — confirming
`SubmitModule`'s expression-only `def` items cannot express this without
an explicit recursor, since there's no room for command-level
`termination_by`/`decreasing_by` modifiers; (2) the explicit
`Nat.strongRecOn` term compiled fine, but the base-case `rfl` failed
because `Nat.strongRecOn` (built on `WellFounded.fix`) is not
definitionally reducible — fixed by using the `Nat.strongRecOn_eq`
unfolding lemma via `simp` instead.

Closes the "well-founded recursion via `SubmitModule`" backlog item;
every `LOOP.md`-listed recursion technique (structural, mutual,
well-founded) is now demonstrated in this domain. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; commit `12cc467`, scoped to only these two new files. Full
`packets/elementary/induction/` revalidated clean at 21 packets, 0
errors, 0 warnings as of this update.

## Proposed update — geometry false_generalization negative example (this agent, 2026-07-08)

Added `packets/negative/geometry/slope_div_mul_division_by_zero_unguarded.v1.json`
(geometry's 3rd negative example, 1st false_generalization) plus companion
`packets/elementary/geometry/slope_div_mul_not_always_cancel.v1.json` — a
kernel-verified disproof of the unconditional div-then-mul cancellation
claim via witness x1=x2=0, y1=0, y2=5. Commit `4631802`. Corpus crossed
250 total packets this cycle (233 verified public / 17 negative) --
approaching but not yet at the v0.1 release criteria (>=250 public,
>=25 negative); public is at 93%, negative at 68%.

## Proposed update — induction elementary packet: euclid_gcd_eq_gcd (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Picked up induction's explicitly
flagged, previously-deferred backlog item: well-founded (non-structural)
recursion via `SubmitModule` (Euclidean `gcd`), which the domain's own
`QUEUE.md` sanctioned "a few failed tries or fall back to a negative
example if it doesn't land."

Worked it through a probing episode under the name `myGcd` (episode
`d83a52a3`, 4 steps, eventually `kernel_verified`) — proved
`myGcd b a = Nat.gcd b a` via `WellFoundedLT.fix` + `WellFoundedLT.fix_eq`
+ strong induction. Real diagnostics along the way: (1) `Nat.strongRecOn`
compiles fine as a `def` body but its application does not reduce by
`rfl`; (2) switching to `WellFoundedLT.fix` + `WellFoundedLT.fix_eq`
progressed further but a bare `show ...; rw [WellFoundedLT.fix_eq]` still
left an unclosed goal, because the target side still referenced the
folded definition name — fixed with `unfold <name>; rw
[WellFoundedLT.fix_eq]`, which unfolds both sides uniformly; (3)
`Nat.gcd_rec` is ambiguous about which occurrence of `Nat.gcd _ _` it
rewrites in a goal with `Nat.gcd` on both sides — fixed by instantiating
it explicitly (`Nat.gcd_rec b a`).

Before authoring, discovered another concurrent agent had already landed
`elementary.induction.mygcd_wellfounded.v1` in the same
`MathCorpus.Elementary.Induction` namespace, also named `myGcd`, proving
only the base case `myGcd a 0 = a` (a different, weaker statement, so not
a `packet_id` duplicate — but a real Lean top-level-identifier collision
risk across the two standalone modules). Renamed to `euclidGcd`
throughout and re-ran the identical, already-debugged proof recipe
end-to-end through a fresh tracked episode (`a4a2a972`,
`kernel_verified` on the first attempt) rather than hand-editing an
already-verified script, since the corpus's core rule is that only a
kernel-checked tracked episode is proof authority.

Added `packets/elementary/induction/euclid_gcd_eq_gcd.v1.json`:
`euclidGcd b a = Nat.gcd b a` for all `b, a`, strengthening the domain's
well-founded-recursion coverage from a base-case-only fact to full
correctness. Schema-validated (`validate_packets.py --check-hashes
--warn-as-error`: 0 errors) and hash-stamped. Also condensed
`packets/elementary/induction/DASHBOARD.md`'s per-packet bullet list into
a summary paragraph (same growing-unbounded problem another agent already
fixed in the combinatorics dashboard this session). Commit scoped to only
this cycle's own files.

## Proposed update — combinatorics elementary packet #12 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/card_sdiff_of_subset.v1.json`:
`t <= s -> (s \ t).card = s.card - t.card` — the domain's first
set-difference cardinality packet, alongside its existing union/
intersection family. Proved directly via `Finset.card_sdiff_of_subset`.
Produced via tracked episode `236baad7-7206-4e5b-9eb1-e9ad0c8e8e35`
(problem_version `83f0da2d-2160-44d2-af80-b2c046d48810`, dev-attested),
`kernel_verified` on the first `solve` attempt. Closes that item in
`packets/elementary/combinatorics/QUEUE.md`; remaining next-target is a
general (non-concrete) pigeonhole statement generalizing
`pigeonhole_3_into_2`. Schema-validated (`validate_packets.py
--check-hashes --warn-as-error`: 0 errors) and hash-stamped; full corpus
revalidated clean at 252 packets, 0 errors, 0 warnings as of this update
(per `corpus_stats.py`: 235 verified public + 17 negative, corpus crossed
the roadmap's 250-file mark last cycle per another agent's note).

## Proposed update — inequalities elementary packet: abs_sub_le (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress (the logged `episode_observe`
bug has a documented workaround); negative examples still the biggest raw
gap (17/25, 68%) but every domain lane already has coverage, so priority-2
doesn't select a target. Elementary is close to the v0.1 public target
(235/250, 94%). Direct file counts: inequalities (21) and induction (22)
both had empty `QUEUE.md` "Next targets" again. Picked `inequalities` and,
rather than the deferred/complex `InequalityEstimateKit`-gated backlog
item (general n-term AM-GM), added a fresh L1 item to continue offsetting
this domain's persistent L2_olympiad skew (15/21 packets before this
cycle, only 2 L1_proof_basics).

Added `packets/elementary/inequalities/abs_sub_le.v1.json`: the
metric-distance triangle inequality `|a-c| <= |a-b| + |b-c|`, distinct
from the already-authored additive `abs_add_le`/`abs_add_three` and from
`reverse_triangle`. Produced via tracked episode
`a7e193b6-76fc-4f94-8f67-2b6150691653` (problem_version
`7011eabc-b512-43e7-b708-51132ff20102`, dev-attested), `kernel_verified`
on the first `solve` attempt (`abs_cases` on `a-b`, `b-c`, `a-c` — 8
branches — closed uniformly by plain `linarith`, since every branch is
purely linear once the absolute values unfold, unlike the `nlinarith`
needed for the additive forms).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Also condensed
`packets/elementary/inequalities/DASHBOARD.md`'s growing per-packet
bullet list into a summary paragraph (same fix already applied to the
combinatorics and induction dashboards this session — worth generalizing
into a standing convention rather than re-discovering it per domain).
Commit scoped to only this cycle's own files.

## Proposed update — functions elementary packet: fixed_point_id (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no new bugs/triage requiring in-repo action; fresh
`python tools/corpus_stats.py` showed 237 verified public + 17 negative
(254 files, 94.8% of the v0.1 public target, only 13 to go). Induction's
`QUEUE.md` (22 packets) drained again — a concurrent agent independently
strengthened the well-founded-recursion demo to full correctness
(`euclid_gcd_eq_gcd` alongside this agent's own prior-cycle
`mygcd_wellfounded`, both preserved as distinct packets). Moved to
`functions` (23), whose `QUEUE.md` still named `fixed_point_id` as the
last open item on its stated "fixed point basics" focus.

Added `packets/elementary/functions/fixed_point_id.v1.json`: `id x = x`
for all `x` (`rfl`). Produced via tracked episode
`3952d582-bed1-445c-8826-f676342e25d3` (problem_version
`611e8581-2b92-4d5d-9661-bf737436d1d0`, dev-attested), `kernel_verified`
on the first attempt. Closes `fixed_point_id` in
`packets/elementary/functions/QUEUE.md`; every named focus topic in that
domain's `README.md` (injective, surjective, composition, monotone,
fixed-point) now has at least one packet. Remaining open backlog item
there: a concrete image/preimage identity.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `c777d80`, scoped to only these two new
files. Full `packets/elementary/functions/` revalidated clean at 24
packets, 0 errors, 0 warnings as of this update.

## Proposed update — algebra negative example: div_mul_cancel (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no new bugs beyond the already-logged
`episode_observe` UNIQUE-constraint issue. `python tools/corpus_stats.py`
showed 238 verified public + 17 negative (255 files), 95.2% of the
250-packet v0.1 public target — very close to release on the public-count
criterion. Checked `packets/elementary/induction/QUEUE.md` (folder-count
smallest at 22) — fully saturated again (empty next-targets/backlog,
heavy concurrent-agent activity). Per-domain negative-example counts:
algebra/combinatorics/functions/induction at 2 each, geometry/inequalities/
number_theory at 3 — picked algebra's queued
`packets/negative/algebra/QUEUE.md` item, "ring on a division identity
without field_simp".

Added `packets/negative/algebra/div_mul_cancel_bare_ring_no_hypothesis_failure.v1.json`:
`a / b * b = a` for nonzero `b`, attacked with bare `ring` in a fresh
tracked episode `e292756d-c2f5-4bf4-a211-8b827e3751d4` (problem_version
`a87737c1-a4b9-47f4-ad1b-750d0f797928`, dev-attested). Step 1 genuinely
`kernel_fail`'d, reducing to the un-cancelled residual `a * b * b⁻¹ = a`
(`ring` cannot use the `b ≠ 0` hypothesis to justify the cancellation).
Step 2, `field_simp`, closed the same episode `kernel_verified`.
Discovered mid-cycle that a concurrent agent had independently landed a
similar item (`frac_sum_bare_ring_missing_field_simp.v1.json`, on
`1/a + 1/b = (a+b)/(a*b)`) for the same queue entry — kept both, since
they're distinct concrete statements with distinct `packet_id`s (no schema
collision) and the tracked evidence for mine was already genuine and
verified; noted the overlap in `packets/negative/algebra/QUEUE.md` rather
than discarding either.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 258 packets,
0 errors, 0 warnings as of this update (240 verified public + 19 negative
per `corpus_stats.py`, 96.0% of the 250-packet v0.1 public target, 19/25
negative examples — both criteria very close to done). Commit scoped to
only this cycle's own files.

## Proposed update — algebra negative example, concurrent near-duplicate resolved (this agent, 2026-07-08)

Added `packets/negative/algebra/frac_sum_bare_ring_missing_field_simp.v1.json`
plus companion `packets/elementary/algebra/sum_reciprocals_eq_sum_over_product.v1.json`
(`field_simp; ring`). Commit `f1bb1c9`. Landed the same cycle as another
agent's independent `div_mul_cancel_bare_ring_no_hypothesis_failure.v1`
(same underlying lesson -- ring can't use a nonzero hypothesis to cancel
`x * x⁻¹` -- different concrete statement). That packet's own notes
already decided to keep both rather than discard tracked evidence; this
agent aligned with that call rather than re-litigating it. Also confirmed
BUGS.md's logged `episode_observe` UNIQUE-constraint bug has a documented
workaround and is not blocking -- left untouched rather than attempting a
fix outside this repo's own tooling (it's in the external proofsearch MCP
server).

## Proposed update — combinatorics elementary packet #13 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/pigeonhole_general.v1.json`: the
general (non-concrete) pigeonhole principle — for arbitrary `s t : Finset
ℕ` with `t.card < s.card` and `f` mapping `s` into `t`, some two distinct
elements of `s` collide under `f`. Proved directly via
`Finset.exists_ne_map_eq_of_card_lt_of_maps_to`, the same lemma the
existing concrete `pigeonhole_3_into_2` instance specializes. Produced via
tracked episode `d9b60f62-3d2a-4c1e-b222-737c11f4855d` (problem_version
`6602d267-ce39-45ed-aa9c-1ab58a73bfd4`, dev-attested), `kernel_verified`
on the first `solve` attempt. Closed `packets/elementary/combinatorics/QUEUE.md`'s
last remaining item; added a new `card_filter_add_card_filter_not`
candidate (verified the declaration exists in Mathlib first) — the domain
has `filter_subset'` but no filter counting/partition identity yet.
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 259 packets,
0 errors, 0 warnings as of this update.

## Proposed update — functions elementary packet: image_union (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. Induction (22) and
inequalities (23) both had empty `QUEUE.md` next-targets again; `functions`
(24, direct count) still had one open backlog item explicitly named in
the domain's stated focus: image/preimage basics, never covered by any
prior packet.

Added `packets/elementary/functions/image_union.v1.json`:
`f '' (s ∪ t) = f '' s ∪ f '' t`, the domain's first image/preimage
packet. Produced via tracked episode
`5ca732f2-a04c-49ab-ae90-a9ba120ea336` (problem_version
`9cfa3f07-5a70-4484-81e2-1476300426eb`, dev-attested), `kernel_verified`
on the third `solve` attempt. Two hand-unfolded set-extensionality
attempts (nested `·` bullets under `constructor`/`rintro`/`rcases`)
kernel-failed first: one under the default `flat_tactic_sequence`
transport (bullet structure lost, a bound variable went out of scope),
one under `raw_lean_block` (a leading-indentation mismatch on the first
line produced `introN failed: no additional binders`) — a new
tactic-transport data point beyond the binder-arity and bullet/flat
issues logged on earlier packets in this domain. Switched to directly
citing `Set.image_union` (confirmed to exist via
`mathlib_search_declarations` first), which kernel-verified cleanly.
Closes the last open item in `packets/elementary/functions/QUEUE.md`
(every focus-list topic from the domain's `README.md` now has >=1
packet).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Also condensed
`packets/elementary/functions/DASHBOARD.md` and `QUEUE.md` into summary
form (same fix already applied to combinatorics/induction/inequalities
this session — recommend the dev-loop agent bake "condense before it
grows unbounded" into a standing per-domain convention rather than
leaving it to be independently rediscovered every cycle). Commit scoped
to only this cycle's own files.

## Proposed update — functions elementary packet: preimage_inter (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; fresh `python tools/corpus_stats.py`
showed 242 verified public + 19 negative (261 files, 96.8% of the v0.1
public target, only 8 to go). Induction (23) and inequalities (23) queues
both fully drained (only inequalities' deferred L2/L3 general-AM-GM
backlog item remains anywhere). Functions' `QUEUE.md` named its own two
remaining suggestions: a preimage counterpart to the already-landed
`image_union`, or a second monotone-family lemma. Picked the preimage
counterpart to complete the image/preimage pair.

Added `packets/elementary/functions/preimage_inter.v1.json`: `f ⁻¹' (s ∩
t) = f ⁻¹' s ∩ f ⁻¹' t`, cited directly via `Set.preimage_inter`.
Produced via tracked episode `c14540a7-13b3-4576-9da5-b9d491b3e198`
(problem_version `2878a8fe-d4a6-4419-8b51-d0fa1bf2abfa`, dev-attested),
`kernel_verified` on the first attempt (no bullet-transport hazard this
time, unlike `image_union`'s hand-unfolded attempt — went straight to the
direct citation). Completes the image/preimage pair in
`packets/elementary/functions/`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `5c093d8`, scoped to only these two new
files. Full `packets/elementary/functions/` revalidated clean at 26
packets, 0 errors, 0 warnings; full corpus at 243 verified public + 19
negative (97.2% of the v0.1 public target, 7 to go) as of this update.

## Proposed update — combinatorics elementary packet #14 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/card_filter_partition.v1.json`:
`(s.filter (fun a => a % 2 = 0)).card + (s.filter (fun a => ¬ (a % 2 =
0))).card = s.card` — a predicate (evenness, as a concrete instance) and
its negation partition a finite set's cardinality. Proved via
`Finset.card_filter_add_card_filter_not`. Produced via tracked episode
`5229559a-e7cd-468f-bdea-6f64506ccc1e` (problem_version
`c763beb6-5c08-4397-bea1-234fbd678296`, dev-attested), `kernel_verified`
on the third `solve` attempt — the first two mis-guessed the lemma's
argument order/arity (`Finset.card_filter_add_card_filter_not` takes only
the predicate explicitly; the `Finset` argument is inferred from the
goal), hitting `type_mismatch`/`parse_error` `kernel_fail`s before a
single-underscore application succeeded; recorded in the packet's own
`notes` rather than split into a separate negative example, since it's an
argument-arity slip rather than an automation/tactic-mismatch hazard with
independent training value. Closed
`packets/elementary/combinatorics/QUEUE.md`'s `card_filter_add_card_filter_not`
item; added a new `Finset.sum`/`Finset.prod` candidate (verified
`prod_range_succ` exists in Mathlib first) now that it's the only
remaining gap versus the domain's README focus list. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; full corpus revalidated clean at 263 packets, 0 errors, 0
warnings as of this update.

## Proposed update — geometry elementary packet: right_triangle_area_half_base_height (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. `python tools/corpus_stats.py`
showed 244 verified public + 19 negative (263 files) — 97.6% of the
v0.1 public target (only 6 more elementary packets needed) and 76% of
the negative-example target (6 more needed there too). Direct file
counts: induction and inequalities tied smallest at 23, both with
genuinely empty `QUEUE.md` next-targets yet again this cycle. Moved to
the next domain in line, `geometry` (33), which had one concrete open
item: `right_triangle_area_half_base_height`.

Added `packets/elementary/geometry/right_triangle_area_half_base_height.v1.json`:
for a right angle at vertex B, the square of twice the shoelace
signed-area term equals the product of the two legs' squared lengths —
the squared form of Area = (1/2)*base*height, via the unconditional
Lagrange identity `|u|^2|v|^2 - (u.v)^2 = (cross u v)^2` specialized to
the right-angle case. Produced via tracked episode
`db18efdb-8e8d-4b70-a150-f6f0cade1c3c` (problem_version
`30cd2f41-69a7-40a6-9aa9-76d956a63002`, dev-attested), `kernel_verified`
on the first `solve` attempt in that episode, via `linear_combination`.

Notable slip along the way: an earlier problem_version (episode
`3c3b1994`) named the y-coordinate of vertex B `by` — colliding with
Lean's `by` tactic-block keyword. The root statement itself registered
without error (problem_create only hashes the text), but the proof term
hit a hard parse error (`unexpected token 'by'; expected ')'`) the moment
it tried to `intro`/reference that variable. Abandoned via `give_up` and
retried with the variable renamed to `by1`. Worth flagging as a general
lesson for future geometry/algebra packets using short single-letter-ish
coordinate names: avoid `by`, and probably also `at`, `from`, `do`, `in`,
`fun`, `have`, `show`, `then`, `else` as bare identifiers.

Closes the last open item in `packets/elementary/geometry/QUEUE.md` (only
the `Backlog`-tier law of cosines/sines remain, both flagged as
`GeometryAngleKit`-dependent future work). Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped. Also condensed `packets/elementary/geometry/DASHBOARD.md`
and `QUEUE.md` into summary form (same fix now applied to every
elementary domain touched this session: combinatorics, induction,
inequalities, functions, geometry). Commit scoped to only this cycle's
own files.

## Proposed update — combinatorics negative example (this agent, 2026-07-08)

Added `packets/negative/combinatorics/filter_prime_simp_no_progress.v1.json`
(combinatorics' 3rd negative example) plus companion
`packets/elementary/combinatorics/primes_below_ten_card.v1.json` (`decide`).
Commit `a002a8b`. Corpus is very close to v0.1 now: last full validate
showed 266 packets total; re-derive via `python tools/corpus_stats.py`
for the current public/negative split, but as of this agent's last check
it was ~244/250 public (97.6%) and ~20/25 negative (80%) -- both gaps are
down to single digits.

## Proposed update — combinatorics elementary packet #15 (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/combinatorics/prod_range_succ.v1.json`: `∏ i ∈
range (n+1), f i = (∏ i ∈ range n, f i) * f n` — splitting off the last
factor of a finite product, the domain's first genuine recurrence-style
product identity (previously only trivial `prod_range_one'`/
`prod_range_zero'` existed). Proved directly via `Finset.prod_range_succ`.
Produced via tracked episode `dc35fd64-b61e-4fb2-b041-9609fc81661a`
(problem_version `0aadd47c-1292-4d91-bff5-a4dfab12411b`, dev-attested),
`kernel_verified` on the first `solve` attempt. Closed that
`packets/elementary/combinatorics/QUEUE.md` item. While searching for a
second candidate, tried to verify a guessed `Finset.sum_filter` lemma name
first — it does **not** exist under that name (confirmed via
`mathlib_search_declarations`, no exact match) — so did not queue it;
this is exactly the "verify before queuing" discipline the negative
example lane's own QUEUE.md already models. Queued instead a verified,
genuine gap: no packet in this domain uses plain `Set` (only `Finset`),
despite the README focus text explicitly naming "Finset, Set" — confirmed
`Set.mem_union` exists in `Mathlib.Data.Set.Basic`. Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped; full corpus revalidated clean at 268 packets, 0 errors, 0
warnings as of this update.

## Proposed update — functions elementary packet: strictmono_comp (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. `python tools/corpus_stats.py`
showed 248 verified public + 20 negative (268 files) — 99.2% of the v0.1
public target (only ~2 more elementary packets needed at the time of the
check; other agents' concurrent in-flight commits may have already closed
that gap by the time this lands). Induction (23) and inequalities (24)
both had genuinely empty `QUEUE.md` next-targets again. Moved to
`functions` (26), whose own queue note suggested "a second monotone-family
lemma beyond `monotone_comp`/`strictMono_injective`."

Added `packets/elementary/functions/strictmono_comp.v1.json`: the
composition of two strictly monotone functions (between preorders) is
strictly monotone. Produced via tracked episode
`21aeb6a1-40c0-485b-8bee-abf5530eb0c5` (problem_version
`3f3663c7-5fba-406d-b3e6-e402463d0113`, dev-attested), `kernel_verified`
on the first `solve` attempt (`intro α β γ _ _ _ f g hf hg a b hab; exact
hg (hf hab)`). Completes the monotone-family cluster
(`monotone_comp`, `strictmono_injective`, `strictmono_comp`).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this cycle's own files
to avoid touching other agents' concurrent in-flight work (an induction
negative example and a paired `two_pow_gt_sq_from_five`-style packet were
both present uncommitted in the working tree at the time of this cycle).

## MILESTONE — v0.1 public-packet target reached (250/250, 100.0%) — this agent, 2026-07-08

`python tools/corpus_stats.py` now reports **250 verified public + 22
negative (272 files)** — the roadmap's `>=250 public packets` v0.1
release criterion is met. This crossed during this agent's own cycle
(landed alongside several other concurrent agents' packets in the same
window, including an induction negative example and a paired
`two_pow_gt_sq_from_five` positive/negative pair already present
uncommitted when this tick started).

**This does not mean v0.1 is fully released** — per `docs/roadmap.md`,
the release criteria also require: `>=25 negative examples` (currently
22/25, 3 to go — very close, but not yet met), JSONL + Parquet exports,
HF + GitHub dataset cards, frozen train/val/test_public splits, no known
split-leakage, and a live takedown policy. None of those non-count
criteria have been worked in this session (this has been a packets-only
`/loop` cycle sequence). Recommend the next dev-loop-agent pass (or a
`packets/negative/*` cycle to close the last 3 negative examples first)
turn attention to `tools/export_jsonl.py` / `tools/export_parquet.py` /
`tools/dedupe_pipeline.py` / dataset-card authoring once negative examples
hit 25 — raw packet count is no longer the bottleneck.

This cycle's own contribution (this agent): added
`packets/negative/induction/factorial_gt_two_pow_offbyone_false_base.v1.json`
(commit `76bc8d4`) — attempted `n! > 2^n` via naive induction from `n=0`;
the claim is false at `n=0..3` (true only from `n=4`), so the zero-case
`decide` correctly reports the base-case proposition false, a clean
kernel_fail. Closes the "off-by-one base case error" backlog item in
`packets/negative/induction/QUEUE.md`; this domain's first negative
example in the `false_generalization` gap_category (prior ones there were
`tactic_mismatch` on TRUE statements). Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped.

## MILESTONE — public v0.1 target reached (this agent, 2026-07-08, /loop continuation)

`python tools/corpus_stats.py` now reports **250 verified public + 22
negative (272 files)** — **100.0% of the 250-packet public v0.1 release
target**, with the remaining gap entirely on the negative-example side
(22/25, 3 to go). Full corpus revalidates clean:
`python tools/validate_packets.py packets/ --check-hashes --warn-as-error`
→ 272 packets, 0 errors, 0 warnings.

This cycle's own contribution: independently picked the same
`packets/negative/induction/QUEUE.md` "off-by-one base case error" backlog
item as another concurrent agent (see the section immediately above),
landing a distinct instance. Added
`packets/elementary/induction/two_pow_gt_sq_from_five.v1.json` (`2^n > n^2`
for `n >= 5` — false at `n` in `{2,3,4}`, proved via `Nat.le_induction`
starting the induction at the real threshold rather than `n = 0`) and its
paired `packets/negative/induction/two_pow_gt_sq_offbyone_naive_ih_failure.v1.json`:
plain `induction n with zero | succ` naively invokes `ih (by omega)`
assuming `n >= 5` follows from `n + 1 >= 5`, which is false exactly at the
`n = 4` boundary, so `omega` genuinely `kernel_fail`s ("No usable
constraints found"); `Nat.le_induction` fixes it. Produced via tracked
episode `1fea172d-06f2-447d-a2a1-94a58f47f7cd` (problem_version
`dd3f8e07-1404-4ac6-9465-0e5a6c8f0a83`, dev-attested), 4 steps total (one
genuine tactic failure, two tactic-transport/lemma-name fixes for
`raw_lean_block` indentation and `Nat.le_induction` syntax, then
`kernel_verified`). Kept both this packet and the concurrent agent's
`factorial_gt_two_pow_offbyone_false_base.v1.json` — distinct concrete
statements and distinct `gap_category` (`tactic_mismatch` on a true guarded
statement here, vs. `false_generalization` on an unguarded false statement
there) — noted the overlap in `packets/negative/induction/QUEUE.md` and
`DASHBOARD.md` rather than discarding either.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors each) and hash-stamped; full corpus revalidated clean at 272
packets as stated above.

With the public target now met, the sole remaining v0.1 release-criteria
gap is negative examples (22 -> 25) — recommend every domain agent's next
cycle prioritize negative-example candidates over further elementary bulk
until that closes. Export/tooling work (`tools/export_jsonl.py` etc.,
per `docs/roadmap.md` Phase 6) becomes the natural next phase once it
does.

## Proposed update — functions negative example, v0.1 negative gap down to 2 (this agent, 2026-07-08)

Added `packets/negative/functions/surjective_implies_injective_finite_pigeonhole_misapplied.v1.json`
(functions' 3rd negative example, 1st false_generalization) plus companion
`packets/elementary/functions/surjective_not_always_injective.v1.json` — a
kernel-verified disproof via witness f(n) = n - 1. Commit `5e7eac5`. Last
full validate: 274 packets, 0 errors; corpus_stats.py showed 251 verified
public (100.4% of 250 -- public target already met) and 23 negative
(92% of 25 -- only 2 more needed to close the v0.1 release criteria's
last open gap).

## Proposed update — combinatorics negative example #4 + positive companion (this agent, 2026-07-08, /loop continuation)

With the public target met and the negative-example gap the clear
priority (23/25 at start of this cycle), pivoted from the elementary
`Set.mem_union` queue item to close this domain's own long-queued
negative-example backlog item instead: "`omega`/`decide` timeout
attempting to close a `Finset.card` goal that actually requires an
explicit `Finset.card_image_of_injective`."

Added `packets/negative/combinatorics/card_image_injective_omega_failure.v1.json`:
bare `omega` applied to `(s.image f).card = s.card` given `hf :
Function.Injective f` cannot consume the injectivity hypothesis at all —
it treats `s.card` and `(Finset.image f s).card` as two unrelated opaque
atoms and reports a spurious counterexample. Plus companion positive
packet `packets/elementary/combinatorics/card_image_of_injective.v1.json`
(`Finset.card_image_of_injective` closes it directly). Both produced via
the same tracked episode `5f59b5d8-e34b-4def-9892-5ba68f409d7b` (problem_version
`8123695e-f185-49a4-8533-01f41051ae62`, dev-attested): step 1 (`omega`)
genuinely `kernel_fail`'d, step 2 (the structural lemma) reached
`kernel_verified`. This is combinatorics' 4th negative example and closes
the domain's negative-example QUEUE.md entirely (moved to `## Done`).
Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors each) and hash-stamped; full corpus revalidated clean at 277
packets, 0 errors, 0 warnings as of this update — per this count the
roadmap's negative-example gap is now at most 1 remaining corpus-wide
(24/25 or better, depending on other agents' concurrent in-flight work).

## MILESTONE — v0.1 negative-example target also reached (this agent, 2026-07-08, /loop continuation)

Added `packets/negative/inequalities/cauchy_three_term_bare_nlinarith_failure.v1.json`:
bare `nlinarith` (no hints) fails on the six-variable, degree-4 three-term
Cauchy-Schwarz goal `(ax+by+cz)^2 <= (a^2+b^2+c^2)(x^2+y^2+z^2)`, kernel-
rejected in tracked episode `e9e5244f-0ece-4b32-bc59-8c984a9f0307` (closed
`give_up`); the Lagrange-identity square hints close the same statement on
the first attempt in a separate episode, authored as
`packets/elementary/inequalities/cauchy_three_term.v1.json`.

`python tools/corpus_stats.py` immediately after this commit read **252
verified public + 25 negative (277 files)** — both `docs/roadmap.md` v0.1
numeric release criteria (`>=250 public packets`, `>=25 negative
examples`) are now met simultaneously. This is a raw-count milestone only:
v0.1 per the roadmap also requires schema freeze + docs, the packet
validator in CI (already true), trust/redaction taxonomy enforcement,
JSONL + Parquet exports, HF + GitHub dataset cards, frozen
train/val/test_public splits, a split-leakage audit, and a live takedown
policy — that remaining work is Phase 6 (export/tooling), out of scope
for the elementary/negative-example domain loops and presumably owned by
`agents/github_issues/` (the dev loop agent) or a dedicated export task.
Domain agents should keep adding packets for quality/balance (level-
distribution gaps, cross-domain coverage) rather than treating the count
targets as "done, stop" — but the original scarcity that drove this
loop's priority order (negative examples as "the biggest shortfall") no
longer applies at the same urgency.

(Committed alongside unrelated concurrent combinatorics packets —
`card_image_of_injective.v1.json` / its paired negative example — that
were staged in the shared working tree's index when this commit ran; see
the shared-index race note already recorded earlier in this file for the
`88b7dea` precedent. No corpus content was lost or duplicated; validated
clean at 277/277.)

## Proposed update — combinatorics elementary packet: set_mem_union (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress; confirmed (per the
milestone note immediately above) that both v0.1 numeric release criteria
are now met. Induction and inequalities (tied smallest, 24 each) both had
genuinely empty `QUEUE.md` *and* empty `Backlog` — no invented target
attempted this cycle since several other domains had concrete,
already-verified-to-exist backlog items instead. Picked `combinatorics`'
one ready backlog item: a plain `Set` (not `Finset`) lemma, filling a real
README-stated-focus gap ("Finset, Set") that no prior packet in the
domain had covered.

Added `packets/elementary/combinatorics/set_mem_union.v1.json`:
`a ∈ s ∪ t ↔ a ∈ s ∨ a ∈ t` for `Set α`, cited directly via
`Set.mem_union`. Produced via tracked episode
`d5cb1cff-dba3-418a-8e99-ffecba1d3000` (problem_version
`f0e70f0f-0a36-48c2-97d3-a7a9bfe240f1`, dev-attested), `kernel_verified`
on the first `solve` attempt. Closes the domain's `Set`-vs-`Finset`
README gap and the corresponding `QUEUE.md` item.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Now that both raw-count v0.1 targets are met,
this cycle's target selection leaned toward closing a named quality/focus
gap (per this file's own guidance above: "keep adding packets for
quality/balance... rather than treating the count targets as 'done,
stop'") rather than just any available domain-furthest-behind item.
Commit scoped to only this cycle's own files.

## Proposed update — geometry elementary packet: law_of_cosines (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no new bugs/triage. Both v0.1 count criteria confirmed
met (`python tools/corpus_stats.py`: 253 verified public + 25 negative at
the top of this cycle). Checked `packets/elementary/geometry/QUEUE.md`
(geometry, 37 packets) since induction/inequalities/functions queues were
all previously drained: its backlog explicitly named "Law of cosines" as
the natural next step after `triangle_angle_sum`/`dist_sq_expand`.

Added `packets/elementary/geometry/law_of_cosines.v1.json`: coordinate/
squared-distance form — placing vertices at the origin, `(b, 0)`, and
`(a*cos θ, a*sin θ)`, the squared distance from `(b,0)` to the third
vertex is `a^2 + b^2 - 2*a*b*cos θ`. Produced via tracked episode
`d1f31293-c1bb-421f-aa27-8c7b8f88db8f` (problem_version
`8695aa6a-ee35-42fa-8314-278e0bfa5b6c`, dev-attested), `kernel_verified`
on the first attempt (`nlinarith [Real.sin_sq_add_cos_sq θ]`), matching
the domain's established cos/sin-parametrization convention from
`circle_point_dist_eq_radius`. Tooling note:
`problem_imports: ["Mathlib.Analysis.SpecialFunctions.Trig.Basic"]` was
rejected outright — that module's `.olean` doesn't exist on disk in this
pinned build — fell back to the full `["Mathlib"]` import, which worked
fine here (no repeat of the 60s-timeout issue hit on an unrelated target
two cycles ago; likely load-dependent rather than import-set-dependent).
Closes the "Law of cosines" backlog item; remaining backlog: "Law of
sines" (a natural companion).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `987d5ee`, scoped to only these two new
files. Full `packets/elementary/geometry/` revalidated clean at 35
packets, 0 errors, 0 warnings; full corpus at 254 verified public + 25
negative (101.6% of the v0.1 public target) as of this update.

## Proposed update — number_theory elementary packet: well_ordering (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress; both v0.1 numeric release
criteria remain met (confirmed by two prior milestone notes above).
Induction and inequalities (tied smallest, 24 each) both had genuinely
empty `QUEUE.md` next-targets *and* backlogs again — no invented target
attempted. Picked `number_theory`'s ready backlog item instead:
well-ordering of the naturals, foundational but not yet present.

Added `packets/elementary/number_theory/well_ordering.v1.json`: every
nonempty `Set ℕ` has a least element. Produced via tracked episode
`96e95cc1-bdbf-41b7-b71d-cadd6ed1109a` (problem_version
`3e45015b-93de-48df-93b7-fd2ef402da93`, dev-attested), `kernel_verified`
on the second `solve` attempt — the first used `Nat.strong_induction_on`
+ `by_cases`/bulleted case split under the default `flat_tactic_sequence`
transport and kernel-failed (the bullets lost their case-block
association, a hazard also hit on `id_bijective`/`image_union` in
`packets/elementary/functions/`); resubmitting the identical script under
`proof_format: raw_lean_block` fixed it. Reinforces the growing pattern:
whenever a tactic proof genuinely needs nested `·` bullets (not just a
`<;>`-chained uniform close), prefer `raw_lean_block` from the start
rather than discovering the flat-transport failure first.

Closes the `well_ordering` backlog item in
`packets/elementary/number_theory/QUEUE.md`; remaining backlog: Bezout's
identity (needs `Int`, more involved). Schema-validated
(`validate_packets.py --check-hashes --warn-as-error`: 0 errors) and
hash-stamped. Commit scoped to only this cycle's own files.

## Proposed update — first frontier/erdos packet, both v0.1 milestones reached (this agent, 2026-07-08)

Both v0.1 raw-count release criteria are now met (per concurrent-agent
commits `35ae043` public 250/250, `890a724` negative 25/25). With
elementary and negative-example queues sampled empty across several
domains, this agent moved to priority-4 frontier librarian work per the
standing loop instructions: added
`packets/frontier/erdos/erdos_399_cambie.v1.json` (commit `7280c13`) --
the first packet in the frontier/erdos lane (previously 0 packets).
Cambie's known companion to Erdős #399 (no n! = x^4+y^4 with
gcd(x,y)=1, xy>1), independently re-verified through this repo's own
tracked proof-search loop rather than trusted on the sibling repo's
already-kernel_verified status, per this repo's evidence policy.
`training.eligibility: quarantined` per the default-quarantine policy for
`open_problem_related` packets pending real external review -- the
validator's `open_problem_public` warning caught this correctly on first
pass. Six more sibling-repo-verified companion results are queued and
ready to packetize the same way -- see `packets/frontier/erdos/COMPANION_RESULTS.md`.

## Proposed update — number_theory elementary packet: prime_two (this agent, 2026-07-08, /loop continuation)

Startup this cycle found both v0.1 packet-count release criteria already
met (255 verified public + 25 negative at cycle start, since risen
further via concurrent agents). Checked geometry's `QUEUE.md` (this
agent's most recent domain) — only backlog item left was "Law of sines",
which needs a materially harder trigonometric setup than the corpus's
established coordinate-style proofs (relating two angles' sines via two
independent area expressions) and risked an over-scoped attempt for one
cycle; deferred rather than forcing it. Checked `number_theory` instead,
which had an explicitly flagged, well-scoped, uncontested gap: `prime_two`
— `Nat.Prime 2` — "no primality packets at all" despite extensive
`coprime_*`/`gcd_*`/`even_or_odd` coverage.

Added `packets/elementary/number_theory/prime_two.v1.json`: `Nat.Prime 2`,
closed via `norm_num` in a single tracked-episode step (episode
`86b4db53-554e-4887-a579-adfc290a0cb5`, problem_version
`ccdaf1f3-c193-4540-8c0f-26037fbb2d11`, dev-attested), `kernel_verified`
on the first attempt — no genuine failure to preserve as a negative
example this cycle (the tactic just worked). This domain's first
primality fact; closes the `prime_two` item in
`packets/elementary/number_theory/QUEUE.md` (next up: `not_prime_one`,
which pairs with it, then `prime_dvd_mul`).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 282+ packets
(concurrent commits landing throughout), 0 errors, 0 warnings. Both v0.1
packet-count release criteria remain met; per `python tools/corpus_stats.py`
this cycle: 258 verified public + 25 negative (283 files), 103.2% of the
250-packet public target. A concurrent agent has begun Phase 5 frontier
work (`packets/frontier/erdos/`, see the section immediately above) now
that elementary/negative-example priorities are largely saturated —
consistent with this loop's priority-4 fallback.

## Proposed update — number_theory elementary packet: lcm_comm (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Considered `packets/elementary/geometry/QUEUE.md`'s
remaining backlog item ("Law of sines", flagged L2, a genuinely harder
companion to this agent's prior-cycle `law_of_cosines`, needing angle
machinery beyond a simple two-side-one-angle coordinate setup) but judged
it too risky to gamble a full cycle on blind, given comfortably-safer
alternatives were available; checked combinatorics (queue empty),
algebra, and number_theory instead. Picked number_theory's
`lcm_comm` — flagged in that domain's own `QUEUE.md` as "the biggest
single naming gap": a full `gcd_*` family existed but zero `lcm_*`
packets.

Added `packets/elementary/number_theory/lcm_comm.v1.json`: `Nat.lcm a b =
Nat.lcm b a`, cited via `Nat.lcm_comm`. Produced via tracked episode
`38f8f47e-8517-4ceb-966f-705792b6ab57` (problem_version
`1a968cb9-bfb5-4362-994f-8e3b35a08c19`, dev-attested), `kernel_verified`
on the first attempt. Opens the door for the queue's paired
`dvd_lcm_left`/`dvd_lcm_right` and `gcd_mul_lcm` targets.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `ab325b5`, scoped to only these two new
files. Full `packets/elementary/number_theory/` revalidated clean at 51
packets, 0 errors, 0 warnings; full corpus at 259 verified public + 25
negative (103.6% of the v0.1 public target) as of this update. Also
noted: a concurrent agent's frontier work has now produced its first
packet (`by domain: {..., 'frontier': 1}`, `L7_frontier: 1` in
`python tools/corpus_stats.py`'s level breakdown).

## Proposed update — number_theory elementary packet: even_sq (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress; both v0.1 numeric release
criteria remain well exceeded (259+ public, 25 negative). Inequalities
and induction (tied smallest, 24-25) both had empty `QUEUE.md`
next-targets and backlogs again. Moved to `number_theory`, whose own
queue still had several concrete open items; picked `even_sq` (the
classic parity-of-squares fact from the standard irrationality-of-sqrt-2
proof pattern).

Added `packets/elementary/number_theory/even_sq.v1.json`:
`Even (n^2) <-> Even n`, cited via `Nat.even_pow'` (instantiated at
exponent 2, nonzero side-condition discharged by `norm_num`). Produced
via tracked episode `5bbacd66-df54-4a0f-9dd7-d2aa08b946ba`
(problem_version `08d28744-e7f4-46bb-ac60-5fea242eaa0c`, dev-attested),
`kernel_verified` on the first `solve` attempt.

While updating `packets/elementary/number_theory/QUEUE.md`, found
`lcm_comm` still listed under "Next targets" despite already being
landed by another agent (commit `ab325b5`, noted above) — the queue file
hadn't been synced after that commit. Fixed it here (moved to "Done",
noted the sync gap) to prevent a third agent re-attempting it.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this cycle's own files.

## Proposed update — second frontier/erdos packet (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_349_exists_finset_sum_two_pow.v1.json`
(commit `f495978`, frontier lane now 2 packets). Sublemma for #349's
integer_isGoodPair_iff cluster; root_statement_hash confirmed byte-
identical to upstream. Also recorded a real, actionable blocker: #1113
Sierpinski's sibling-repo proof needs `set_option maxHeartbeats 4000000`,
which SubmitModule forbids clients from setting -- do not re-attempt it
without a workaround (see BLOCKERS.md). Remaining companion-result queue
candidates: #1052 (Subbarao-Warren, unitary perfect numbers even; also a
separate #1052 sigma* multiplicativity infrastructure lemma), #291.ii
(Steinerberger gcd), #494 (Steinerberger product counterexample, ~88
lines, moderate complexity via Finset ℂ/primitive roots), and 6 more
files in the #349 cluster (31-279 lines each).

## Proposed update — functions elementary packet: min_le_max (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress; both v0.1 numeric release
criteria remain well exceeded (262+ public, 25 negative), plus frontier
work now has 2 packets. Induction and inequalities (tied smallest, 25
each) both had empty queues/backlogs again. Moved to `functions` (28),
picking up its own suggested "concrete abs/max/min gap check" candidate.

Added `packets/elementary/functions/min_le_max.v1.json`: `min a b <= max
a b` for reals, filling a real gap — the domain already had
`max_comm`/`max_self`/`min_comm`/`min_self` but no lemma directly
relating min and max. Produced via tracked episode
`562a07a3-c952-4735-9573-2fd802b87e12` (problem_version
`5deb46eb-e151-4bb1-92ef-e89927a55c4e`, dev-attested), `kernel_verified`
on the first `solve` attempt (`le_max_of_le_left (min_le_left a b)`).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this cycle's own files
(other agents' concurrent `prime_dvd_mul` number_theory work was present
uncommitted in the working tree at the time — left untouched).

## Proposed update — number_theory elementary packet: prime_dvd_mul (this agent, 2026-07-08, /loop continuation)

This agent is the owner of the `prime_dvd_mul` work referenced just
above (confirming it's now committed, not left uncommitted). Startup this
cycle: no bugs/triage; both v0.1 numeric release criteria remained well
exceeded. Picked `packets/elementary/number_theory/QUEUE.md`'s
`prime_dvd_mul` item — flagged there as "the single most reusable
primality lemma for later divisibility work."

Added `packets/elementary/number_theory/prime_dvd_mul.v1.json`: for prime
`p`, `p ∣ a * b ↔ p ∣ a ∨ p ∣ b` (`hp.prime.dvd_mul`). Produced via
tracked episode `b42295d9-b384-4458-844a-ddb1115bc8d3` (problem_version
`821d1652-59d6-4762-ba89-8c3a2d93da16`, dev-attested), `kernel_verified`
on the first accepted attempt. A prior `problem_version` using the
default Ring+NormNum-only import manifest kernel-failed with "the
environment does not contain `Nat.Prime`" — that name simply isn't
available under the narrow manifest — switched to
`problem_imports: ["Mathlib"]` (matching this domain's `prime_two`
packet), which resolved cleanly. Closes the `prime_dvd_mul` item; commit
`7cc9f60`, scoped to only these two new files.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Full corpus at 264 verified public + 25
negative (105.6% of the v0.1 public target) as of this update.

## Proposed update — number_theory elementary packet: not_prime_one (this agent, 2026-07-08, /loop continuation)

Added `packets/elementary/number_theory/not_prime_one.v1.json`: `¬
Nat.Prime 1`, closed via `norm_num` in a single tracked-episode step
(episode `ec66cf9d-8d79-4e2c-9178-e016e854a709`, problem_version
`851ba6da-4cb6-4bca-b138-b2a0534b497f`, dev-attested), `kernel_verified`
on the first attempt. Pairs with this agent's earlier `prime_two.v1`;
closes the `not_prime_one` item in
`packets/elementary/number_theory/QUEUE.md`. Found that `prime_dvd_mul`
had already been landed by a concurrent agent (commit `7cc9f60`, see the
section immediately above) — synced the domain's `QUEUE.md` to reflect it
rather than duplicating.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 290 packets,
0 errors, 0 warnings (265 verified public + 25 negative per
`corpus_stats.py`, 106.0% of the 250-packet v0.1 public target — both
packet-count release criteria remain comfortably met).

## Proposed update — number_theory elementary packet: gcd_mul_lcm (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress; release criteria remain
comfortably met. Induction and inequalities (tied smallest, 25 each)
both had empty queues/backlogs again. Moved to `number_theory`, which
still had `gcd_mul_lcm` and `dvd_lcm_left`/`dvd_lcm_right` open; picked
`gcd_mul_lcm` (flagged as "good reusable lemma for the `core_algebra`/
`ring_automation` kits").

Added `packets/elementary/number_theory/gcd_mul_lcm.v1.json`:
`Nat.gcd a b * Nat.lcm a b = a * b`, cited directly via `Nat.gcd_mul_lcm`.
Produced via tracked episode `f6352ddf-5a46-4adf-ac9a-4036cb887f47`
(problem_version `66791830-fea6-43fa-93b5-3596dfb73442`, dev-attested),
`kernel_verified` on the first `solve` attempt. Ties the domain's
`gcd_*` and `lcm_*` families together.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Also condensed
`packets/elementary/number_theory/QUEUE.md`'s "Done" list into summary
form (same fix already applied across every other elementary domain this
session). Commit scoped to only this cycle's own files (another agent's
concurrent `one_le_two_pow` induction packet was present uncommitted in
the working tree — left untouched).

## Proposed update — third frontier/erdos packet (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_494_product.v1.json` (commit
`523bdef`, frontier lane now 3 packets). Steinerberger's counterexample
disproving the multiplicative analogue of Erdős's sum-subset question.
Submitted as SubmitModule (1 def + 2 theorems), moderate complexity (62
LOC). Hit and fixed a reusable lesson: the sibling repo's proofs often
rely on `open Finset`/similar for unqualified names, but `SubmitModule`
module_items get no `open` preamble -- fully-qualify (e.g.
`Finset.mapEmbedding` not `mapEmbedding`) when transporting. Noted in
COMPANION_RESULTS.md for future frontier cycles. Remaining queue: #1052
(two files, Subbarao-Warren + sigma* multiplicativity, 322+367 lines --
substantial), #291.ii (Steinerberger gcd, 162 lines), 6 more #349 cluster
files (31-279 lines), and #1113 Sierpinski remains blocked (see
BLOCKERS.md).

## Proposed update — number_theory elementary packet: dvd_lcm_left (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained well exceeded (268 verified public + 25 negative at the top of
this cycle). `packets/elementary/number_theory/QUEUE.md`'s remaining
"Next targets" item was the paired `dvd_lcm_left` / `dvd_lcm_right`.

Added `packets/elementary/number_theory/dvd_lcm_left.v1.json`: `a ∣
Nat.lcm a b` for all naturals (`Nat.dvd_lcm_left`). Produced via tracked
episode `2a1c9884-ee7c-4ac2-bdce-1851d6f44372` (problem_version
`401d7ada-73e9-4e62-839a-38d304bd7b9a`, dev-attested), `kernel_verified`
on the first attempt. Deliberately did NOT also author `dvd_lcm_right`
this same cycle despite having already registered its problem_version
(`741cbcaa-ec83-435b-96e2-6d4ff9ec8517`, no episode/proof attempt run
against it) — this loop's own instructions say work exactly one deep
target per firing, not batch multiple; left `dvd_lcm_right` for the next
cycle (its problem_version is already registered and ready to reuse).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `4f5f263`, scoped to only these two new
files. Full `packets/elementary/number_theory/` revalidated clean at 56
packets, 0 errors, 0 warnings; full corpus at 269 verified public + 25
negative (107.6% of the v0.1 public target) as of this update.

## Proposed update — number_theory elementary packet: dvd_lcm_right (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. Inequalities and induction
(tied smallest, 25-26) both had empty queues/backlogs again. Moved to
`number_theory`'s remaining open item — `dvd_lcm_right`, exactly the item
a prior cycle's agent had deliberately left for "the next cycle" per the
note immediately above (one-target-per-firing discipline).

Added `packets/elementary/number_theory/dvd_lcm_right.v1.json`:
`b ∣ Nat.lcm a b`, cited directly via `Nat.dvd_lcm_right`. Produced via a
fresh tracked episode `b9c09daf-fb35-4808-9fbe-03045acb506a`
(problem_version `617796e7-411c-4555-aea0-1998d3baab30`, dev-attested) —
did not reuse the previously-registered but unattempted problem_version
`741cbcaa-ec83-435b-96e2-6d4ff9ec8517` mentioned above, since a fresh
`problem_create` was simpler than looking up and reusing a bare
problem_version_id from a prior status note; both would have produced
the same statement. `kernel_verified` on the first `solve` attempt.
`theorem_name: dvd_lcm_right'` (trailing apostrophe) to avoid shadowing
Mathlib's own `Nat.dvd_lcm_right`, matching the sibling `dvd_lcm_left'`
convention. Closes the `gcd_*`/`lcm_*` family's last open item.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Also condensed
`packets/elementary/number_theory/DASHBOARD.md` into summary form (same
fix now applied across every elementary domain touched this session).
Commit scoped to only this cycle's own files.

## Proposed update — algebra elementary packet: pow_add (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. `packets/elementary/number_theory/QUEUE.md`
(this agent's last two cycles) is now fully condensed and empty of open
next-targets (concurrent agents cleared `dvd_lcm_left'`/`dvd_lcm_right'`/
`gcd_mul_lcm` since — see sections above). Checked geometry (only "law of
sines" backlog remains, deferred previously as needing a materially
harder trigonometric setup), inequalities/functions/combinatorics/induction
(all condensed to empty next-targets) before finding a genuinely open,
well-scoped item in `packets/elementary/algebra/QUEUE.md`: `pow_add`.

Added `packets/elementary/algebra/pow_add.v1.json`: `x^(m+n) = x^m * x^n`
for a real base and natural exponents, closed via `ring` in a single
tracked-episode step (episode `fa0521fa-5205-4059-9071-c5519c5f3392`,
problem_version `22df11f4-ad00-4915-9861-45964e927855`, dev-attested),
`kernel_verified` on the first attempt. Closes the `pow_add` item in
`packets/elementary/algebra/QUEUE.md` (remaining next targets: `pow_mul`,
`neg_sq`, `sub_mul`, `add_sq_three`, `div_add_div_same`, `pow_succ'`).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 297 packets,
0 errors, 0 warnings (272 verified public + 25 negative per
`corpus_stats.py`, 108.8% of the 250-packet v0.1 public target — both
packet-count release criteria remain comfortably met).

## Proposed update — algebra elementary packet: sub_mul (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained comfortably exceeded. Checked induction/inequalities/
number_theory queues (all fully drained again — `dvd_lcm_right` from this
agent's own prior-cycle note already landed via a concurrent agent).
Moved to `packets/elementary/algebra/QUEUE.md`'s remaining next-targets;
`pow_add` had already landed by another agent, so picked `sub_mul` (the
missing subtraction counterpart to the existing `mul_add'`/`add_mul'`).

Added `packets/elementary/algebra/sub_mul.v1.json`: `(a - b) * c = a*c -
b*c` for integers, cited via `sub_mul`. Produced via tracked episode
`ed63843f-3795-45fb-bfb6-79ae2b8a512f` (problem_version
`88b29a89-9409-480f-94f1-5b2b6ab0deeb`, dev-attested), `kernel_verified`
on the first attempt. Closes the `sub_mul` item; remaining queue targets:
`pow_mul`, `neg_sq`, `add_sq_three`, `div_add_div_same`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `0427733`, scoped to only these two new
files. Full `packets/elementary/algebra/` revalidated clean at 45
packets, 0 errors, 0 warnings; full corpus at 273 verified public + 25
negative (109.2% of the v0.1 public target) as of this update.

## Proposed update — fourth frontier/erdos packet, largest module yet (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_291_infinite_gcd_gt_one.v1.json`
(commit `e234834`, frontier lane now 4 packets). Steinerberger's
gcd(a_n,L_n)>1 companion for Erdős #291 part (ii). Largest SubmitModule
transported here so far (2 defs + 5 helper theorems + root, 8 items) --
took 4 attempts to get right. Key finding, now documented in
COMPANION_RESULTS.md: helper module items are ALWAYS forced through the
flattener regardless of requested proof_format, so (1) every
`have h := by tac1; tac2` followed by sibling tactics needs explicit
parens `(by tac1; tac2)` or the flattener swallows the trailing tactics
into the wrong scope, and (2) bullet-based case splits inside a helper
must be rewritten bullet-free (Or.elim/.elim term-mode dispatch) since
bullets don't survive forced flattening -- only the root theorem can use
raw_lean_block to keep bullets. This generalizes the smaller lesson from
the #494 packet and should make future multi-item modules much faster.

## Proposed update — induction elementary packet: factorial_pos_induction (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. Induction and inequalities
(tied smallest, 26 each) both had empty `QUEUE.md` next-targets/backlogs
again — but induction's own notes flagged a real, still-unaddressed
quality gap: a 24:1 `L1_proof_basics`:`L0_elementary` level skew (only
`two_pow_gt_self` and `one_le_two_pow` were `L0` before this cycle).
Picked a fresh, genuinely-D0 induction target to continue narrowing it,
rather than moving to a different domain.

Added `packets/elementary/induction/factorial_pos_induction.v1.json`:
`0 < n!`, proved by a genuine self-contained induction (base case `0! =
1`, successor case via `Nat.factorial_succ` + `Nat.mul_pos`) — distinct
from `packets/elementary/number_theory/factorial_pos.v1`, which is a
bare `Nat.factorial_pos` citation with no inductive content. Produced via
tracked episode `d6963e91-cc3b-4c20-85ca-de8257294ba2` (problem_version
`0f8460fb-115e-4b6f-8e36-efcc62c22568`, dev-attested), `kernel_verified`
on the first `solve` attempt.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Narrows the domain's L0/L1 skew to roughly
8:1; more genuinely-D0 additions would help further (see updated
`DASHBOARD.md`/`QUEUE.md`). Commit scoped to only this cycle's own
files.

## Proposed update — algebra elementary packet: neg_sq (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained comfortably exceeded (276 verified public + 25 negative at the
top of this cycle). `packets/elementary/algebra/QUEUE.md`'s snapshot was
slightly stale (this agent's own prior-cycle `sub_mul` wasn't reflected
yet) but `neg_sq` was still genuinely open — confirmed no existing file
before starting.

Added `packets/elementary/algebra/neg_sq.v1.json`: `(-a)^2 = a^2` for
integers, closed by `ring`. Produced via tracked episode
`2ccf64f3-8550-4f90-b1c1-9c2d90dd2811` (problem_version
`84ca94c8-db4a-492f-bec1-4c6ec026b49d`, dev-attested), `kernel_verified`
on the first attempt. Closes the `neg_sq` item; remaining queue targets:
`pow_mul`, `add_sq_three`, `div_add_div_same`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `bd04c9d`, scoped to only these two new
files. Full `packets/elementary/algebra/` revalidated clean at 46
packets, 0 errors, 0 warnings; full corpus at 278 verified public + 25
negative (111.2% of the v0.1 public target) as of this update.

## Proposed update — induction elementary packet: prod_range_pos (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. Induction and inequalities
(tied smallest, 27 each) both had empty queues/backlogs again. Stayed in
`induction` (per its own notes: more general-lemma / level-balance work
is still welcome even with an empty explicit queue) and added a fresh
general reusable lemma.

Added `packets/elementary/induction/prod_range_pos.v1.json`: the product
of positive terms over a `Finset.range` is positive, complementing the
domain's existing `prod_range_succ`/`prod_range_monotone`. Produced via
tracked episode `bdbcc4ba-515a-4841-bd7c-e17a73f82152` (problem_version
`53ffc576-1cca-4d26-b0f2-2125fe3b025c`, dev-attested), `kernel_verified`
on the first `solve` attempt — deliberately wrote the case split as
`| zero => ... | succ k ih => ...` with no nested `·` bullets, to avoid
the flat_tactic_sequence transport hazard that has repeatedly hit bulleted
proofs elsewhere in this corpus (`id_bijective`, `image_union`,
`well_ordering`).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this cycle's own files.

## Proposed update — fifth frontier/erdos packet + timeout blocker isolated (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_349_one_two_is_good_pair.v1.json`
(commit `5abf22f`, frontier lane now 5 packets, 2/7 of the #349
integer_isGoodPair_iff cluster). Single Solve step, kernel_verified on
first attempt. Also isolated a genuine environment limit: a sibling proof
needing field_simp/push_cast over a division timed out twice at the
~60-second wall-clock cap (distinct from the maxHeartbeats issue found
earlier); the division-free version of the same proof shape elaborated
fine, confirming the division-clearing step specifically is what's slow.
Recorded in BLOCKERS.md with a suggested workaround (Decompose into
smaller sub-obligations) for whoever revisits it.

## Proposed update — algebra elementary + negative pair: pow_mul (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage beyond the already-known
`episode_observe` UNIQUE-constraint issue. `packets/elementary/algebra/QUEUE.md`
(this agent's prior cycle) was stale — `neg_sq` and `sub_mul` had already
landed via concurrent agents (commits `bd04c9d`, `0427733`) without the
queue file being synced; fixed that and picked the next genuinely open
item, `pow_mul` (companion to this agent's earlier `pow_add`).

Added `packets/elementary/algebra/pow_mul.v1.json`: `x^(m*n) = (x^m)^n`
for a real base and natural exponents. Interesting parallel to the
frontier timeout noted in the section immediately above: a bare `ring`
attempt (which closed the sibling `pow_add` goal instantly) genuinely
timed out after 60s on this one — `ring` cheaply normalizes a *sum* of
variable exponents but not a *product* of two. Preserved as
`packets/negative/algebra/pow_mul_ring_timeout_failure.v1.json`, a new
`sub_category` (deterministic timeout, not a clean tactic rejection) for
this domain's negative-example lane. `exact pow_mul x m n` closed the
same tracked episode `13c20f38-d366-44f6-95be-95d9216d102d` (problem_version
`d07c4a9f-f64c-429b-93b9-72391f4ee59a`, dev-attested) `kernel_verified`.
Closes the `pow_mul` item in `packets/elementary/algebra/QUEUE.md`
(remaining next targets: `add_sq_three`, `div_add_div_same`, `pow_succ'`).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors each) and hash-stamped; full corpus revalidated clean at 306
packets, 0 errors, 0 warnings (280 verified public + 26 negative per
`corpus_stats.py`, 112.0% of the 250-packet v0.1 public target — both
packet-count release criteria remain comfortably met, negative examples
now at 26/25).

## Proposed update — functions elementary packet: image_inter_subset (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. Induction and inequalities
(tied smallest, 28 each) both had empty queues again (another agent had
`max_add_le` in flight uncommitted in `inequalities` — left untouched).
Moved to `functions`, which had one flagged candidate: `image_inter`, the
image-of-an-intersection companion to `image_union`/`preimage_inter`.
The domain's own queue note warned the naive equality version is false in
general (needs `f` injective) and would need either an injectivity
caveat or a counterexample-based negative example — sidestepped that by
authoring the always-true *subset* statement instead (the standard
Mathlib-aligned formulation), which is a clean, unconditional, genuinely
useful lemma on its own.

Added `packets/elementary/functions/image_inter_subset.v1.json`:
`f '' (s ∩ t) ⊆ f '' s ∩ f '' t`, cited directly via
`Set.image_inter_subset` (confirmed to exist first via
`mathlib_search_declarations`). Produced via tracked episode
`6eaaf620-beae-4f46-82c5-7269ae10c876` (problem_version
`d8f2142a-f843-4fe2-ba5c-f914b3c4630d`, dev-attested), `kernel_verified`
on the first `solve` attempt. Closes the `image_inter` item; the
domain's image/preimage focus area is now: `image_union`,
`preimage_inter`, `image_inter_subset`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Also re-condensed
`packets/elementary/functions/DASHBOARD.md`/`QUEUE.md`, which had grown
long again since the last condensing pass. Commit scoped to only this
cycle's own files.

## Proposed update — algebra elementary packet: div_add_div_same (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained comfortably exceeded (282 verified public + 26 negative at the
top of this cycle). `packets/elementary/algebra/QUEUE.md`'s `pow_mul` had
already landed via a concurrent agent; picked the remaining
`div_add_div_same` — no division-identity packet existed in this domain.

Added `packets/elementary/algebra/div_add_div_same.v1.json`: `a/c + b/c =
(a+b)/c` for reals, closed by `ring`. Produced via tracked episode
`cd6b4dc2-2049-4ea3-b5a0-b611938d7b1d` (problem_version
`63937d82-0d46-40d2-ba01-37c0d5ceb991`, dev-attested), `kernel_verified`
on the second attempt — the first tried citing an identifier named
`div_add_div_same` directly, which isn't in scope under this pinned
Mathlib rev; `ring` closed it directly instead (handles the field-division
junk-value convention at `c = 0` automatically). Closes the
`div_add_div_same` item; remaining queue target: `add_sq_three`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `dbc6e6a`, scoped to only these two new
files. Full `packets/elementary/algebra/` revalidated clean at 48
packets, 0 errors, 0 warnings; full corpus at 283 verified public + 26
negative (113.2% of the v0.1 public target) as of this update.

## Proposed update — sixth frontier/erdos packet (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_349_alpha_le_one_not_is_good_pair.v1.json`
(commit `2fa52c6`, frontier lane now 6 packets, 3/7 of the #349
integer_isGoodPair_iff cluster, and 3/4 of that cluster's four assembly
pieces). Single Solve step, kernel_verified on first attempt, no
division/field_simp so it avoided the wall-clock timeout hit earlier.
Only `Erdos349_alpha_gt_two_not_isGoodPair.lean` (159 lines, likely the
4th and largest assembly piece) remains to complete the assembly-piece
set; after that, `Erdos349_integer_isGoodPair_iff.lean` (279 lines, the
culminating iff) becomes attemptable.

## Proposed update — algebra elementary packet: quad_formula_real_root (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. Induction and inequalities
(tied smallest, 28 each) both had empty queues again. Checked geometry
next (`law_of_sines` was the only open backlog item, but encoding
"angle opposite a side" cleanly from bare coordinates — without more
machinery than this domain's existing packets use — looked like a
genuinely harder target than warranted for one cycle) and picked
algebra's `quad_formula_real_root` backlog item instead: nonnegative
discriminant implies a real root, building on the existing
`quad_form_nonneg`.

Added `packets/elementary/algebra/quad_formula_real_root.v1.json`.
Produced via tracked episode `9435347e-fd20-4198-aa9c-7252a8499a93`
(problem_version `a675545c-064c-4bae-920a-8ecb1af5ff2d`, dev-attested),
`kernel_verified` on the third `solve` attempt. Genuine debugging
sequence, not a transport hazard this time: (1) `nlinarith [hs]` alone
couldn't expand the needed `(√D - b)(√D + b)` product after `field_simp`;
(2) switched to `linear_combination hs` (the right tool for an equality
goal that's a polynomial consequence of another equality) but hit `ring
failed, ring expressions not equal` — `field_simp` had reordered one
occurrence of the sqrt's argument (`b^2 - 4*a*c` vs `b^2 - a*4*c`), and
`ring`/`linear_combination` cannot see through `Real.sqrt` to recognize
the two resulting sqrt terms as the same atom even though their
arguments are ring-equal; (3) fixed by `set`-ing the sqrt term to a plain
variable *before* `field_simp`/`linear_combination`, so both tactics only
ever see one opaque atom. General lesson worth remembering for any future
`Real.sqrt`/`Real.exp`/etc.-involving algebra: `set` the transcendental
subterm early, before any tactic that might resyntax its argument.

While updating `packets/elementary/algebra/QUEUE.md`, found
`div_add_div_same` already landed (commit `dbc6e6a`, noted above) but
still listed as open — synced it. Also found the algebra backlog's
"geometric series closed form" item is already effectively covered by
`packets/elementary/induction/geom_series_sum_induction.v1.json` (ℤ) and
`packets/elementary/functions/geom_series_mul.v1.json` (ℝ) — noted this
in the queue rather than authoring a third near-duplicate.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this cycle's own files
(another agent's concurrent `add_sq_three` was present uncommitted in the
working tree — left untouched).

## Proposed update — algebra elementary packet: add_sq_three (this agent, 2026-07-08, /loop continuation)

This agent is the owner of the `add_sq_three` work referenced just above
(confirming it's now committed, not left uncommitted). Startup this
cycle: no bugs/triage; both v0.1 numeric release criteria remained
comfortably exceeded (286 verified public + 26 negative at the top of
this cycle).

Added `packets/elementary/algebra/add_sq_three.v1.json`: `(a+b+c)^2 =
a^2+b^2+c^2+2ab+2bc+2ca` for integers, closed by `ring`. Produced via
tracked episode `29f871d5-eac9-47f7-a959-759e2eb1bb8f` (problem_version
`a01d135a-39f8-4487-8b7b-788bfb0cb8f0`, dev-attested), `kernel_verified`
on the first attempt. This appears to close out
`packets/elementary/algebra/QUEUE.md`'s originally-listed items entirely
(a concurrent agent has since started on the deferred quadratic-formula
backlog item, `quad_formula_real_root`, present uncommitted in the
working tree at the time of this update — left untouched).

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `4104f56`, scoped to only these two new
files. Full `packets/elementary/algebra/` revalidated clean at 50
packets, 0 errors, 0 warnings; full corpus at 287 verified public + 26
negative (114.8% of the v0.1 public target) as of this update.

## Proposed update — algebra elementary packet: pow_succ' (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Picked up `packets/elementary/algebra/QUEUE.md`'s
last two open items, `add_sq_three` and `pow_succ'`. Ran a tracked episode
for `add_sq_three` (episode `a3bdf47a-6539-438d-bc19-bdeaa8f53d85`,
`kernel_verified` on the first attempt via `ring`) but, before authoring a
packet, discovered a concurrent agent had already landed
`elementary.algebra.add_sq_three.v1` with the identical statement moments
earlier — did not duplicate; that episode's evidence is real but simply
didn't become a packet.

Picked `pow_succ'` instead: `x^(n+1) = x^n * x` for a real base and
natural exponent, closed via `ring` in a single tracked-episode step
(episode `869150c9-d993-498d-94d3-d6f4c94cfd30`, problem_version
`a48b82a2-33df-4e01-85d3-62c67267f188`, dev-attested), `kernel_verified`
on the first attempt. Named `pow_succ.v1` at the packet/file level per
this repo's convention of dropping the trailing apostrophe from
identifiers-with-primes in packet_ids (matching `dvd_lcm_left'`/
`dvd_lcm_right'` -> `dvd_lcm_left.v1`/`dvd_lcm_right.v1`) while keeping
the apostrophe in the actual Lean `theorem_name`. This empties
`packets/elementary/algebra/QUEUE.md`'s "Next targets" section entirely
for now.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 314 packets,
0 errors, 0 warnings (288 verified public + 26 negative per
`corpus_stats.py`, 115.2% of the 250-packet v0.1 public target — both
packet-count release criteria remain comfortably met). Commit scoped to
only this cycle's own files.

## Proposed update — number_theory elementary packet: bezout (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress. Inequalities (28) and
induction (29) both had empty queues/backlogs again; functions (30) and
combinatorics were also dry. Checked geometry's remaining backlog item
(`law_of_sines`) but judged encoding "angle opposite a side" cleanly from
bare coordinates a genuinely harder target than warranted for one cycle
(same call as a prior cycle). Picked `number_theory`'s sole remaining
backlog item instead: Bezout's identity over `Int`.

Added `packets/elementary/number_theory/bezout.v1.json`: for every pair
of integers `a, b`, `gcd(a,b)` is expressible as `a*u + b*v` for some
integers `u, v`. Produced via tracked episode
`5d1a3305-2713-49a8-abc3-8ca51930e6e0` (problem_version
`84f130e6-84ef-4995-a112-ba1f8006fa5a`, dev-attested), `kernel_verified`
on the first `solve` attempt (`⟨Int.gcdA a b, Int.gcdB a b,
Int.gcd_eq_gcd_ab a b⟩`). This domain's first `Int`-based (rather than
`Nat`-only) gcd fact; closes the last item in
`packets/elementary/number_theory/QUEUE.md`.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped. Commit scoped to only this cycle's own files.

## Proposed update — seventh frontier/erdos packet, milestone: #349's 4 assembly pieces complete (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_349_alpha_gt_two_not_is_good_pair.v1.json`
(commit `9c681a0`, frontier lane now 7 packets, 4/7 of the #349
integer_isGoodPair_iff cluster). This completes all four assembly pieces
(one_two, alpha_le_one, alpha_gt_two, plus the earlier exists_finset_sum_two_pow
sublemma). Largest single-theorem proof transported here so far (118 LOC),
kernel_verified on the first attempt -- notably beating the sibling repo's
own 3-attempt history and defying the expectation from an earlier timeout
that field_simp-heavy proofs are risky; length/complexity isn't a reliable
timeout predictor on its own. Next natural target: the culminating
279-line integer_isGoodPair_iff.lean assembly, now attemptable since all
four pieces exist (will likely need a large SubmitModule referencing them
as in-scope lemmas -- or re-deriving them inline if cross-problem lemma
references aren't supported). Remaining untouched queue: #1052 (2 large
files), #1113 (blocked, see BLOCKERS.md), and int_coeff_ge_two (35 lines).

## Proposed update — frontier/erdos dossier work: #1052 source review (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress; every elementary domain's
`QUEUE.md` was genuinely dry (only deferred/complex backlog items like
`law_of_sines`, general-n AM-GM remained, each explicitly flagged as
needing more infrastructure than one cycle warrants) and no negative-
example domain had zero coverage — so, per priority order, moved to
priority-4 frontier work. This loop's own instructions frame priority-4
as **dossier-building, not new proof claims** (distinct from — and more
conservative than — `packets/frontier/erdos/LOOP.md`'s own broader
proof-transport mandate that other concurrent agents have been running
this session), so this cycle did source-review/librarian work rather
than attempting a new tracked proof-search episode.

Read `packets/frontier/erdos/{OPEN_PROBLEMS,COMPANION_RESULTS,
PARTIAL_RESULTS,BLOCKERS,SOURCE_REVIEW}.md`, then the sibling repo's
`ErdosProblems/erdos-1052/proof/Erdos1052_sigmaStar_and_bounds.lean` in
full for the theorem `PARTIAL_RESULTS.md` had already flagged as a
"candidate standalone packet once source-reviewed" but never actually
reviewed: `omega_odd_le_two_adic_add_one` (for a unitary-perfect
`2^a * m` with `m` odd, `m.primeFactors.card <= a + 1`).

Findings written to `packets/frontier/erdos/SOURCE_REVIEW.md` (detailed
notes) plus updates to `PARTIAL_RESULTS.md` and `COMPANION_RESULTS.md`:
(1) the Lean-proved content is exactly the counting bound above, sound
and matching `attack-plan.md`'s M3 sketch; (2) the "forces a real 6th
unitary perfect number to be divisible by 2^8" consequence additionally
needs Wall's 1988 theorem, which is cited but **not formalized anywhere**
in this stack — a future packet's `informal_statement` must state only
the Lean-proved bound, with the Wall-theorem consequence confined to
`notes` and clearly marked external/unformalized (an anti-overclaim
check this lane's own conventions require); (3) the theorem's actual
Lean dependency chain is `sigmaStar_mul_of_coprime` ->
`sigmaStar_prime_pow` -> `two_pow_card_primeFactors_dvd_sigmaStar` ->
`omega_odd_le_two_adic_add_one`, all in the same sibling file — the
first of these is exactly `COMPANION_RESULTS.md`'s long-standing
"General σ* multiplicativity" row (also `(none yet)` packetized), so
**that infrastructure should land as its own packet first**, closing
that row, before `omega_odd_le_two_adic_add_one` is attempted on top of
it; (4) transport will need a genuine multi-lemma `SubmitModule` with
several bullet-heavy helpers needing bullet-free rewrites (this lane's
own `#291.ii`/`#494` precedent: ~4 attempts each for smaller modules) —
flagged as **not a one-cycle target**, so no proof-search episode was
attempted this cycle.

No packet JSON touched; only the three dossier markdown files. Commit
scoped to only this cycle's own files.

## Proposed update — frontier packet: Erdős #1052 companion infrastructure (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained comfortably exceeded (290 verified public + 26 negative at the
top of this cycle). Checked induction, inequalities, functions, algebra,
number_theory, combinatorics, and every negative-example queue — all
genuinely drained (Next targets empty everywhere; only deferred/harder
backlog items like geometry's "Law of sines" and algebra's now-completed
quadratic-formula item remain). Per this loop's priority order
(bugs > zero-coverage negative examples > furthest-behind elementary
domain > frontier), this is the first cycle this session where frontier
work was the honest next step rather than a fallback.

Read `packets/frontier/erdos/OPEN_PROBLEMS.md`/`COMPANION_RESULTS.md`/
`BLOCKERS.md` per that folder's `LOOP.md`. Picked the Subbarao–Warren
"unitary perfect numbers are even" companion (#1052) — flagged
`(none yet)` packetized despite being `kernel_verified` in the sibling
repo. Read the sibling repo's
`ErdosProblems/erdos-1052/proof/Erdos1052_even_of_isUnitaryPerfect.lean`
(322 lines, 1 def + 8 helper lemmas + root theorem) and judged the full
transport too large/risky for one cycle: three of the eight helpers
(`proper_eq_erase`, `filter_not_dvd_eq_uDiv_ordCompl`) use `constructor` +
`·`-bullet `Iff` splits, and two (`sum_uDiv_factor`'s `Finset.sum_bij'`,
`sum_uDiv_even`'s `Finset.sum_involution`) use deeply NESTED bullets
(bullets inside bullets) — all of which must be rewritten bullet-free
since `SubmitModule` helper items are always flattened. Rather than
gamble the whole assembly blind, scoped this cycle to the smallest
self-contained useful piece: `uDiv` (def) + `mem_uDiv` + `self_mem_uDiv` +
`proper_eq_erase` (root) — the bridge between the corpus's
`properUnitaryDivisors` convention and `uDiv`.

Added `packets/frontier/erdos/erdos_1052_proper_eq_erase.v1.json`.
Produced via tracked episode `59a627f1-368a-4470-a8b6-bc08e5c70a7d`
(problem_version `41662057-906e-478a-9593-de5cf47322a7`, dev-attested,
`problem_imports: ["Mathlib"]`), `kernel_verified` on the FIRST
`submit_module` attempt — the one bullet hazard in this bounded scope
(`proper_eq_erase`'s `constructor; · A; · B`) rewrote cleanly as
`Iff.intro (fun ... => A) (fun ... => ?_)`, continuing the remaining goal
linearly (a single-`?_` `refine` never needs bullets). ANTI-OVERCLAIM
recorded in the packet's own `notes`: this is bounded companion
infrastructure, not Erdős #1052 itself (open) and not yet the full
`even_of_isUnitaryPerfect` headline result — the harder `sum_bij'`/
`sum_involution` lemmas are explicitly left for a future cycle.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `cd5fe12`, scoped to only these two new
files. Full `packets/frontier/erdos/` revalidated clean at 8 packets, 0
errors, 0 warnings; full corpus at 291 verified public + 26 negative
(116.4% of the v0.1 public target) as of this update.

## Proposed update — eighth frontier/erdos packet (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_349_int_coeff_ge_two_not_is_good_pair.v1.json`
(commit `3c8f696`). Frontier lane now has ~9 packets total (this agent's 8
plus one concurrent #1052 packet landed mid-cycle -- see git log for
`cd5fe12`). 5/7 of the #349 integer_isGoodPair_iff cluster now packetized;
only the culminating 279-line integer_isGoodPair_iff.lean assembly
remains. Avoided colliding with the concurrent agent's #1052 sigmaStar
infrastructure work (flagged as their priority target in
COMPANION_RESULTS.md/SOURCE_REVIEW.md) by picking a different, smaller
#349 target instead this cycle.

## Proposed update — number_theory elementary packet: sq_mod_two_eq_self_mod_two (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Checked every elementary domain's
`QUEUE.md` fresh — all "Next targets" sections were empty
(algebra/number_theory/combinatorics/induction/inequalities/functions),
except geometry's "law of sines" backlog item, which this agent has
twice now assessed as needing a materially harder trigonometric setup
than this corpus's coordinate-proof convention supports cheaply (relating
two vertex angles via cross-product-based sine definitions) — deferred
again rather than forcing a risky attempt. Checked negative-example
queues instead and found a genuine, well-specified, previously-flagged
gap: `packets/negative/number_theory/QUEUE.md`'s
`sq_parity_omega_nonlinear_failure` entry explicitly noted its follow-up
positive packet (the correct case-split proof) was "still open (not
attempted this cycle)" from an earlier agent.

Added `packets/elementary/number_theory/sq_mod_two_eq_self_mod_two.v1.json`:
`n^2 % 2 = n % 2` for all naturals n, closed via `Nat.even_or_odd` case
split + `ring_nf`/`omega` in a single tracked-episode step (episode
`d656e3da-c561-40fc-ad33-ba04213fb8ff`, problem_version
`2340dad3-c687-4a68-8fa7-3e3293e8a213`, dev-attested), `kernel_verified`
on the first attempt. Closes the standing gap between this domain's
negative example (bare `omega` fails on the un-split goal) and its
correct positive companion.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 319 packets,
0 errors, 0 warnings (293 verified public + 26 negative per
`corpus_stats.py`, 117.2% of the 250-packet v0.1 public target). Commit
scoped to only this cycle's own files.

## Proposed update — frontier/erdos dossier work: correcting #470's "immediate win" mischaracterization (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs blocking progress; every elementary domain's
`QUEUE.md` remained genuinely dry (re-checked `induction`/`inequalities`/
`functions` fresh — no ready items) and no negative-example domain had
zero coverage, so stayed in priority-4 frontier dossier work (this
loop's own instructions frame priority-4 as source-review/librarian
work, not new proof-search episodes — see the prior cycle's note on why
this is more conservative than `packets/frontier/erdos/LOOP.md`'s own
broader mandate). Read `COMPANION_RESULTS.md`'s remaining untouched Lane
1 item — `#470 erdos_470.variants.weird_pos_density`, framed as a "good
next companion-result target" / "immediate win" — and actually opened
its source file rather than trusting the framing.

Finding: **the "immediate win" characterization is wrong for this
specific item.** Every other Lane 1 item this session (#1052's
`even_of_isUnitaryPerfect`, #291.ii, #349's cluster, #399, #494) had an
*actual existing Lean proof* in the sibling repo's `ErdosProblems/`
folders — `sorry` in the corpus, but genuinely solved and transportable.
`weird_pos_density` has no such proof anywhere; it's the *only* place
the statement exists, and it needs an original formalization of
Benkoski–Erdős's 1974 analytic-density argument, built on
`Set.HasPosDensity` (an asymptotic `liminf`/`partialDensity` construction
in `FormalConjecturesForMathlib/Data/Set/Density.lean`, itself real
analytic machinery, not a finite computation). Scope is closer to this
lane's #672/#9 "multi-session marathon" items than a one-cycle transport.

Corrected `packets/frontier/erdos/COMPANION_RESULTS.md`'s Lane 1 note and
added detailed findings to `SOURCE_REVIEW.md`, explicitly flagging this
as **not recommended** without a dedicated, separately-scoped attack
plan. This prevents a future cycle from spending an episode budget
expecting a quick transport and hitting a wall of missing infrastructure
instead. No proof-search episode attempted (read-only review); no
packet JSON touched. Commit scoped to only this cycle's own files.

## Proposed update — frontier packet: Erdős #1052 companion infrastructure, part 2 (this agent, 2026-07-08, /loop continuation)

Continued this agent's own prior-cycle `erdos_1052_proper_eq_erase`
infrastructure. Startup this cycle: no bugs/triage; both v0.1 numeric
release criteria remained comfortably exceeded (293 verified public + 26
negative at the top of this cycle). Re-checked every elementary/negative
queue — still fully drained.

Added `packets/frontier/erdos/erdos_1052_not_dvd_div_ordproj.v1.json`:
redeclares `uDiv`/`mem_uDiv` (SubmitModule submissions are self-contained
per episode) and adds `ordProj_dvd_of_mem_uDiv` (a unitary divisor of `n`
divisible by prime `p` is divisible by `n`'s full `p`-part) plus the root
`not_dvd_div_ordProj` (removing that full `p`-part from a divisor leaves
a `p`-free quotient). Produced via tracked episode
`2d9c2f64-cbed-4832-b79d-d5521592e752` (problem_version
`ac4911a9-a44e-47a0-8a4f-d1df1330bdd9`, dev-attested,
`problem_imports: ["Mathlib"]`), `kernel_verified` on the FIRST
`submit_module` attempt. Unlike the prior packet, neither of these two
lemmas needed bullet-free rewriting at all (no `.`-bullet splits in the
sibling source) — only the standard `have h := by tac1; tac2` ->
`have h := (by tac1; tac2)` parenthesization fix (applied once, in
`ordProj_dvd_of_mem_uDiv`'s `happ`).

Still not the headline `even_of_isUnitaryPerfect` result:
`filter_not_dvd_eq_uDiv_ordCompl` (an `Iff` bullet split, same fix pattern
as the prior packet), `sum_uDiv_factor` (a `Finset.sum_bij'` 5-argument
bijection with deeply NESTED bullets), and `sum_uDiv_even` (a
`Finset.sum_involution` 4-argument involution) remain deferred — the
latter two are the genuinely hard remaining pieces.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `aab21a8`, scoped to only these two new
files. Full `packets/frontier/erdos/` revalidated clean at 10 packets, 0
errors, 0 warnings; full corpus at 294 verified public + 26 negative
(117.6% of the v0.1 public target) as of this update.

## Proposed update — MILESTONE: #349 cluster complete via culminating packet (this agent, 2026-07-08)

Added `packets/frontier/erdos/erdos_349_integer_is_good_pair_iff.v1.json`
(commit `312dc1c`). This is the culminating theorem for Erdős #349's
integer characterization: for positive integers t, alpha, (t,alpha) is
good iff t=1 and alpha=2. By far the largest proof transported in this
lane (280 LOC/~210 tactics), combining all four previously-packetized
sublemmas re-embedded as local haves. Kernel-verified on the FIRST
attempt -- the strategy of debugging each piece as its own standalone
packet first, then re-assembling the already-working tactic scripts, is
worth repeating for any future large multi-lemma culminating target.
This closes out the #349 cluster (6/7 files packetized; the 7th is a
trivial corpus-shape wrapper). Frontier lane now at 9 packets from this
agent alone this session, plus several more from a concurrent agent
working #1052 in parallel.

## Proposed update — dossier: formal_conjectures survey pilot (this agent, 2026-07-08)

Priority-4 dossier work (elementary queues confirmed dry across
induction/inequalities/functions; no blocking bugs; the #1052 σ*
multiplicativity infrastructure chain I flagged in a prior cycle is
being actively worked by a different concurrent agent, so I avoided
duplicating it and picked a fresh target instead).

`packets/frontier/formal_conjectures/` had been completely untouched all
session — every tracking file (`SOURCE_MAP.md`, `STATEMENT_FIDELITY.md`,
`OPEN_QUEUE.md`, `SOLVED_QUEUE.md`, `PROOF_ATTEMPTS.md`, `BLOCKERS.md`)
was still empty scaffolding. `SOLVED_QUEUE.md`'s own "Next targets"
section explicitly called for a survey of the sibling `formal-conjectures`
checkout's non-Erdős categories for `research solved`-tagged statements
shipped as bare `sorry` — the same discovery pattern that produced the
Erdős-lane companion-result wins earlier this session. No survey had
been done yet, so I ran it.

Grepped all 16 non-Erdős top-level categories for
`@[category research solved ...]` tags (160 files total across the
checkout) and fully hand-triaged the six smallest (12 files: `Books/`,
`HilbertProblems/`, `LittProblems/`, `Millenium/`, `OptimizationConstants/`,
`OpenQuantumProblems/`) as a bounded pilot, deferring the eight large
categories (`Wikipedia/` 60, `GreensOpenProblems/` 30,
`WrittenOnTheWallII/` 21, `Paper/` 12, `Arxiv/` 9, `OEIS/` 7,
`Mathoverflow/` 5, `Other/` 5) to future cycles.

Findings (full detail in `packets/frontier/formal_conjectures/SOLVED_QUEUE.md`
and `SOURCE_MAP.md`): most of the 12 files are genuinely `sorry` for hard
original mathematics (Poincaré conjecture, Hilbert's 5th/17th problems,
Bugeaud Hausdorff-dimension results, an equidistribution claim, an
Eisenstein-integrality claim, named-paper numeric bounds) — correctly
out of scope. Two files (`OpenQuantumProblems/13.lean` and `35.lean`)
contain several already-fully-proven `research solved` theorems
(`ame_2_exists`, `ame_3_exists`, `ame_2_2_exists`, `ame_3_2_exists`,
`mutuallyUnbiasedBases_dim2`) with explicit, complete proofs — the
pattern that would normally mean an easy transport win. Checked their
dependency chains before flagging them as a real target (the same
anti-overclaim discipline applied to the #470 correction last cycle) and
found they sit on ~500 lines of file-local custom quantum-state
infrastructure (`BlochVec`, `EuclideanSpace ℂ (Config n d)`,
`mkStateVector`, MUB machinery) rather than pure Mathlib, unlike every
Erdős-lane win this session. Recorded as a real but NOT one-cycle
candidate — would need a dedicated multi-cycle push to also transport
the supporting API. One file (`Books/BorweinSineSeries.lean`) has a
`research solved` tag pointing to an external `formal_proof` link not yet
replayed in this environment, structurally identical to the #1052
AlphaProof-link situation — flagged as unverified pending that read, not
claimed either way.

No proof-search episodes run this cycle (dossier-only work, no proof
claims). No packet JSON touched. Files updated:
`packets/frontier/formal_conjectures/SOLVED_QUEUE.md` (survey findings,
replacing the generic "next targets" placeholder) and
`packets/frontier/formal_conjectures/SOURCE_MAP.md` (13 new rows for the
files actually reviewed). Committed separately from any packet work.

## Proposed update — frontier packet: Erdős #1052 companion infrastructure, part 3 (this agent, 2026-07-08, /loop continuation)

Continued this agent's own `erdos_1052_proper_eq_erase` /
`erdos_1052_not_dvd_div_ordproj` infrastructure chain. Startup this
cycle: no bugs/triage; both v0.1 numeric release criteria remained
comfortably exceeded (295 verified public + 26 negative at the top of
this cycle); every elementary/negative queue still fully drained.

Added `packets/frontier/erdos/erdos_1052_filter_ordcompl.v1.json`:
redeclares `uDiv`/`mem_uDiv` and proves the root
`filter_not_dvd_eq_uDiv_ordCompl` — the `p`-free unitary divisors of `n`
are exactly the unitary divisors of the `p`-free part `ordCompl[p] n`.
Produced via tracked episode `32ac25bb-f5a9-4899-9994-91aaf799082b`
(problem_version `93ac7bac-dcbc-46d1-90c2-39bfbe11c157`, dev-attested,
`problem_imports: ["Mathlib"]`), `kernel_verified` on the FIRST
`submit_module` attempt — reused the exact `Iff.intro`-with-nested-`by`
bullet-free template that worked for the prior `proper_eq_erase` packet's
`constructor` + two `.`-bullet case split, confirming that template
generalizes to this lane's other `Iff`-shaped helper proofs.

Still not the headline `even_of_isUnitaryPerfect` result: only
`sum_uDiv_factor` (a `Finset.sum_bij'` 5-argument bijection with deeply
NESTED bullets — bullets inside bullets) and `sum_uDiv_even` (a
`Finset.sum_involution` 4-argument involution) remain, both genuinely
harder than anything transported in this chain so far and explicitly
deferred to a future cycle with dedicated budget.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `2213587`, scoped to only these two new
files. Full `packets/frontier/erdos/` revalidated clean at 12 packets, 0
errors, 0 warnings; full corpus at 296 verified public + 26 negative
(118.4% of the v0.1 public target) as of this update.

## Proposed update — inequalities false_generalization pair: amgm_wrong_direction (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage. Swept every elementary domain's
`QUEUE.md` fresh — all "Next targets" sections empty except geometry's
"law of sines" (deferred again, same reasoning as prior cycles: needs a
materially harder cross-product-based angle setup than this corpus's
coordinate-proof convention supports cheaply). Checked negative-example
queues instead and found two genuinely open items:
`packets/negative/inequalities/QUEUE.md`'s "AM-GM in the wrong direction"
and `packets/negative/number_theory/QUEUE.md`'s "decide on an unbounded
primality-style claim". Picked the former.

Ran two tracked episodes. First, the false universal claim `(a+b)/2 <=
sqrt(a*b)` for positive a, b (AM-GM with the direction flipped), attacked
with the same `nlinarith` hint set that closes the correct-direction
statement: genuinely `kernel_fail`'d ("linarith failed to find a
contradiction") since the claim is actually false, not merely
under-hinted; closed with `give_up` (episode
`ade3dee6-5a63-4a59-bf1a-0ec4e86c89aa`, problem_version
`a8fe23b5-9971-436b-b3d1-0241ba29d49c`). Preserved as
`packets/negative/inequalities/amgm_wrong_direction_bare_nlinarith_failure.v1.json`
— this lane's first `false_generalization`-category example (prior
examples there were all `tactic_mismatch` on true statements).

Second, kernel-verified the falseness directly via an explicit witness
(a=1, b=9: (1+9)/2=5 > 3=sqrt(9)), rewriting `1*9` as `3^2` and applying
`Real.sqrt_sq` (episode `5c239fdd-ef5b-440d-b070-16de9d7d95c0`,
problem_version `87c5b497-625c-4acb-82ef-5c4f857c6c9a`), `kernel_verified`
on the first attempt. Authored as
`packets/elementary/inequalities/amgm_wrong_direction_counterexample.v1.json`.
Together these resolve the queued "AM-GM in the wrong direction"
candidate.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors each) and hash-stamped; full corpus revalidated clean at 324
packets, 0 errors, 0 warnings (297 verified public + 27 negative per
`corpus_stats.py`, 118.8% of the 250-packet v0.1 public target). Commit
scoped to only this cycle's own files.

## Proposed update — geometry: apollonius_median packet (this agent, 2026-07-08)

Priority-3 elementary work this cycle (no blocking bugs; no zero-coverage
negative-example lane; re-checked induction/inequalities/functions
elementary queues, all still genuinely empty). Geometry (34 packets, the
lowest count among domains with any concrete backlog item) had two
backlog entries: "Law of cosines" and "Law of sines". Discovered
`law_of_cosines` had already been landed by a concurrent agent (episode
`d1f31293`) but the queue file was stale — updated it to reflect that.

Investigated "Law of sines" before attempting it: unlike `law_of_cosines`
(a pure algebraic identity reusing the SAME given angle), a faithful law
of sines needs an intrinsically-defined second triangle angle, which
requires either Mathlib's `EuclideanGeometry`/`InnerProductGeometry.angle`
API (a new dependency for this domain) or reintroducing `Real.sqrt`/
division over side lengths — exactly the pattern this domain's packets
have consistently avoided. Confirmed via `mathlib_search_declarations`
that Mathlib has no existing `law_sin`/`law_cos` lemma to wrap. Deferred
as a genuine multi-cycle target rather than forcing a fragile one-cycle
attempt; recorded in `packets/elementary/geometry/QUEUE.md`.

Picked Apollonius's theorem (median length theorem: for triangle ABC
with M the midpoint of BC, AB^2+AC^2 = 2*AM^2+2*BM^2) instead — same
difficulty tier, same coordinate-`ring` style as `midpoint_equidist`,
still missing from the domain. First `problem_create` call omitted
`problem_imports` and defaulted to a Ring+NormNum-only manifest that
doesn't resolve `ℝ`; Lean's autoImplicit silently auto-generalized `ℝ`
as an abstract type, producing a spurious `HSub` instance-synthesis
failure on `ring`. Re-registered with `problem_imports: ["Mathlib"]`
(same fix documented in `law_of_cosines`'s own packet notes) and it went
through immediately via tracked episode `d56cbb06-f2e9-490c-b252-6974aedcf695`
(`intro xA yA xB yB xC yC; ring`, kernel_verified).

Authored `packets/elementary/geometry/apollonius_median.v1.json` +
`lean/MathCorpus/Elementary/Geometry/ApolloniusMedian.lean`, stamped
hashes, validated clean (`python tools/validate_packets.py packets/
--check-hashes --warn-as-error`: 325 packets checked, 0 errors, 0
warnings). Updated `DASHBOARD.md` (34 -> 36 packets — 2 new: this packet
plus retroactively counting the concurrent agent's already-landed
`law_of_cosines`) and `QUEUE.md` in `packets/elementary/geometry/`.
Committed separately, pathspec-scoped to only these files.

## Proposed update — 2026-07-08 (loop agent, number_theory negative-example cycle)

Added a negative/positive companion pair to `number_theory` closing the
QUEUE.md-predicted "decide on an unbounded primality-style claim" gap:
- `negative.number_theory.decide_unbounded_prime_universal.v1` — bare
  `decide` fails on `∀ n : ℕ, ¬ Nat.Prime (4 * n)` (no `Decidable`
  instance for an unbounded universal over ℕ; elaboration failure, not a
  search timeout).
- `elementary.number_theory.four_mul_not_prime.v1` — the working repair
  (`intro n hp; have h2 : (2:ℕ) ∣ 4 * n := ⟨2 * n, by ring⟩; have h3 :=
  hp.eq_one_or_self_of_dvd 2 h2; omega`), kernel_verified.

Both via tracked episode `3148ceed-b740-4b21-a788-7b239face439`
(problem_version `e6dee3bb-782e-412d-90e2-12a0e742b723`). Commit `1b89b92`.
Full-corpus `validate_packets.py --check-hashes --warn-as-error`: 327
packets, 0 errors/warnings. `corpus_stats.py`: 299 public / 28 negative
(v0.1 criteria: both well past target — 250 public / 25 negative). Updated
`packets/negative/number_theory/{QUEUE,DASHBOARD}.md` (queue item closed,
packet count 3->4). No blocking dev-toolchain bugs found in
`agents/github_issues/{BUGS,TRIAGE}.md` this cycle.

## Proposed update — dossier: formal_conjectures survey round 3, Other/ (this agent, 2026-07-08)

Priority-4 dossier work (no blocking bugs; no zero-coverage negative
lane; re-checked all 7 elementary domains' `QUEUE.md` fresh this cycle —
every one is now genuinely empty of concrete ready items, including
geometry after landing `apollonius_median` last cycle). A concurrent
agent had extended my prior `formal_conjectures` survey with a round-2
triage of `Mathoverflow/` (commit `981662d`), finding one genuine
complete-proof candidate (`complexity_five_pow`) blocked by a new,
general finding: `SubmitModule`'s `LeanModuleItem` schema has no
`inductive`/`structure` item kind, so any candidate depending on a
custom inductive type cannot be transported regardless of proof-body
completeness. Recorded in `BLOCKERS.md`.

Continued the same triage with round 3: `Other/` (5 files, the next-
smallest untriaged category). Four files are genuinely hard, out-of-
scope original mathematics (`BeaverMathOlympiad.lean`'s Busy-Beaver-
adjacent sequences, `SchurTruncatedExponential.lean`'s Galois-group
computation, `SuffixPrefixAvoidance.lean`'s isoperimetric bound,
`VCDimConvex.lean`'s VC-dimension results — all `sorry`).

The fifth, `EquationalTheories_677_255.lean` (from the real, active
"Equational Theories" project, Tao et al.), has two genuinely proof-
complete `research solved` theorems
(`Equation255_not_implies_Equation677`, `Finite.` variant) via an
explicit `Fin 3` magma counterexample. Superficially hit the SAME
inductive/structure blocker as round 2's `complexity_five_pow` (the
witnesses are `Magma G` class instances) — but on closer reading,
`Magma`/`Equation255`/`Equation677` are pure notational wrappers (a
`class` with one function field, `abbrev`s unfolding to plain
quantified equalities over that function) that the actual proof never
pattern-matches as a class. Verified the result restates with ZERO
custom types: `∃ op : Fin 3 → Fin 3 → Fin 3, (∀ x, x = op(op(op x x)x)x)
∧ ¬∀ x y, x = op y (op x (op (op y x) y))`, with `op i j := i+j+1`
(checked by hand against the upstream operation table — all 9 entries
match). This is a genuinely ready-to-attempt candidate, unblocked,
sketched in full in `SOLVED_QUEUE.md`.

Generalized this into a reusable lesson in `BLOCKERS.md`: when a
candidate hits the `class`/`structure`/`inductive`-item-kind limitation,
check whether the class is *load-bearing* (proof pattern-matches its
constructors, as `Reachable` was) or *purely notational* (thin wrapper
over a function/data type, as `Magma` is) before writing it off — only
the load-bearing case is a hard stop.

No proof-search episode run this cycle (dossier-only per this agent's
standing priority-4 scope; packet authoring for the `Equation255`
restatement is left for a future cycle or a concurrent agent already
doing full companion-result authoring in this lane, consistent with this
session's established interpretation). No packet JSON touched. Files
updated: `packets/frontier/formal_conjectures/{SOLVED_QUEUE.md,
SOURCE_MAP.md,BLOCKERS.md}`. `Arxiv/` (9 files) and `OEIS/` (7 files) are
now the smallest untriaged categories for a future round.

## Proposed update — Erdős #1052 blocker recorded, no new packet (this agent, 2026-07-08, /loop continuation)

Continued this agent's own `erdos_1052_proper_eq_erase` /
`erdos_1052_not_dvd_div_ordproj` / `erdos_1052_filter_ordcompl` chain.
Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained comfortably exceeded (298+ verified public + 26+ negative at
the top of this cycle).

Attempted `sum_uDiv_factor` — the hardest remaining lemma before the full
`even_of_isUnitaryPerfect` headline theorem (a `Finset.sum_bij'`
5-argument bijection with deeply nested `.`-bullet case splits in the
sibling source). Rewrote it bullet-free using the exact
positional-lambda-argument template that worked cleanly for this chain's
three prior lemmas. The `submit_module` attempt (4 helper items + root)
hit `"Lean invocation timed out after 120 seconds"` — a genuinely large
module (the bijection argument alone has ~60 lines of nested `have`s),
and the timeout gives no signal on whether the underlying logic is
correct. Closed the episode with `give_up` rather than re-attempting
blind, per `LOOP.md`'s "don't auto-fire repeatedly at a known blocker"
guidance.

Recorded the blocker in `packets/frontier/erdos/BLOCKERS.md` (commit
`2cb11ba`) with concrete next-step options for a future cycle: (a) try
`Decompose` to verify the bijection as its own separate obligation before
assembling the full lemma; (b) check for an existing Mathlib
sum-over-filter helper that might sidestep the raw `sum_bij'`; (c) treat
`sum_uDiv_factor` and the still-untried `sum_uDiv_even` (a
`Finset.sum_involution` argument) as a multi-session item, not a
one-cycle retry target. No new packet this cycle — corpus count unchanged
at 299 verified public + 28 negative (119.6% of the v0.1 public target).

## Proposed update — induction: exists_prime_factorization packet (this agent, 2026-07-08)

Priority-3 elementary work this cycle (no blocking bugs; no zero-coverage
negative lane; all 7 elementary domains' `QUEUE.md` confirmed genuinely
dry). Induction and inequalities were tied for lowest packet count (29
each); induction's own `QUEUE.md`/`LOOP.md` explicitly invite
repopulating the backlog from the domain's stated focus (strong
induction, recursion, finite sums/products, factorials, powers) when
empty, matching the same self-derived-target approach used for
geometry's `apollonius_median` last cycle.

Picked "every n>=1 is a product of primes" (existence half of the
fundamental theorem of arithmetic) — a natural extension of the domain's
existing `exists_prime_factor` (which only proves existence of A single
prime factor) to a full factorization list, and a direct match for
`LOOP.md`'s "strong induction" focus item. Proved via strong induction
on the minimal prime factor (`Nat.minFac`).

Took 4 tracked attempts to reach kernel_verified (episode
`f53c8d62-b8ca-4c32-a697-bf17a76bcb58`), each hitting a distinct, now-
documented issue: (1) binding the `1 <= n` hypothesis before calling
`induction n using Nat.strong_induction_on`, combined with `rcases
eq_or_lt_of_le hn`, produced a full 60-second timeout with zero
diagnostic detail — deferring the hypothesis's `intro` to inside the
induction case and replacing `eq_or_lt_of_le` with a plain `by_cases
hn1 : n = 1` fixed it; (2) `rcases hq with rfl | hq` directly on a raw
`List.Mem` hypothesis threw a confusing `subst` error blaming an
unrelated `List ℕ`-typed equality — fixed by converting via
`List.mem_cons.mp hq` to a plain `Or` before rcases-ing; (3) splitting a
`refine ⟨_, ?_, ?_⟩`'s two goals via a flat, unbulleted sequence of
tactics silently left the SECOND goal completely untouched with no
tactic error reported at all (`unsolved_goals`, not a tactic failure) —
fixed by wrapping each `refine` goal in its own single-level `·` bullet.
All three are recorded in the packet's `notes` and in
`packets/elementary/induction/QUEUE.md` for future proofs using
`Nat.strong_induction_on` or multi-goal `refine` in this environment.

Also hit a schema issue unrelated to the proof itself: `domain: "induction"`
is not a valid enum value in `schema/packet.schema.json` (valid domains
are `arithmetic, algebra, number_theory, combinatorics, analysis,
real_analysis, geometry, topology, logic, linear_algebra,
abstract_algebra, set_theory, probability, frontier`) — every existing
packet physically living in `packets/elementary/induction/` actually
tags itself `domain: "algebra"` (confirmed by checking
`factorial_add_ge_mul.v1.json`/`exists_prime_factor.v1.json`), a
folder-vs-schema-domain naming mismatch worth remembering for the next
agent that authors an induction packet from scratch.

Authored `packets/elementary/induction/exists_prime_factorization.v1.json`
+ `lean/MathCorpus/Elementary/Induction/ExistsPrimeFactorization.lean`,
stamped hashes, validated clean. Updated `DASHBOARD.md`/`QUEUE.md` in
`packets/elementary/induction/`. Noted in passing (not touched): a
concurrent agent is actively authoring
`packets/frontier/formal_conjectures/equational_theories_677_255_class_free.v1.json`
this same cycle — exactly the ready-to-attempt candidate this agent's
own prior dossier cycle (commit `7456692`) had sketched and left for
"whichever agent is doing full companion-result authoring in this
lane." Left entirely untouched, consistent with this agent's own
priority-4 dossier-only scope in the frontier folders. Committed only
this cycle's own induction-domain files, pathspec-scoped.

## Proposed update — 2026-07-08 (loop agent, frontier/formal_conjectures first packet)

Authored the first packet in the `frontier/formal_conjectures` lane:
`frontier.formal_conjectures.equational_theories_677_255_class_free.v1`
(Equational Theories project, Tao et al. — Equation 255 does not imply
Equation 677). Picked up a ready-to-attempt candidate a concurrent agent's
triage had already sketched (commit `7456692`, `SOLVED_QUEUE.md` round 3):
the upstream proof is genuinely `sorry`-free but sits on a `class Magma`
typeclass that `SubmitModule` cannot transport (no inductive/class item
kind — see `BLOCKERS.md`). The class is purely notational (never
pattern-matched, only used as a plain binary function), so the result
restates cleanly with zero custom types via `op : Fin 3 -> Fin 3 -> Fin 3`,
`op i j := i+j+1`.

Ran the statement through the full tracked proof-search loop end to end
(`problem_create` -> `episode_create` -> `attempt_claim` -> `episode_step`);
kernel_verified on the first `Solve` attempt, episode
`39013082-f757-41f2-b26b-420d7577a454`. `training.eligibility: quarantined`
(conservative default for this lane's first packet, even though
`open_problem_related: false` for this specific theorem — it's a genuinely
solved literature result, not the file's actual open conjectures).
Commit `8770834`. Updated `SOURCE_MAP.md`, `SOLVED_QUEUE.md` (backlog item
closed), `STATEMENT_FIDELITY.md`.

`corpus_stats.py`: 302 public + 28 negative (330 files; note one
concurrently-in-progress untracked packet,
`packets/elementary/induction/exists_prime_factorization.v1.json`, is
currently failing full-corpus validation with an invalid `domain:
"induction"` — not this agent's file, left untouched for its author to
fix). No blocking dev-toolchain bugs found in
`agents/github_issues/{BUGS,TRIAGE}.md` this cycle.

## Proposed update — priority-4 pivot to frontier: erdos_1052_sigmastar_prime_pow_and_prime (this agent, 2026-07-08, /loop continuation)

Startup this cycle: swept every elementary domain's `QUEUE.md` and every
negative-example lane's `QUEUE.md` fresh — all genuinely empty of open
next-targets (geometry's "law of sines" now has a detailed, explicit
deferral note from another agent confirming this agent's own prior
assessment: needs `InnerProductGeometry.angle`-based infrastructure not
used anywhere else in the domain, not a same-cycle pickup;
number_theory's "decide on unbounded primality" negative-example item was
also closed by a concurrent agent this cycle). Per this loop's priority-4
fallback ("if elementary/negative queues are genuinely empty or blocked,
do dossier-building... in packets/frontier/erdos/"), pivoted to frontier
work for the first time this session.

Read `packets/frontier/erdos/COMPANION_RESULTS.md`, which flagged a
concurrent agent's source-reviewed **priority target**: general `σ*`
(unitary-divisor-sum) multiplicativity infrastructure
(`sigmaStar_mul_of_coprime`, `sigmaStar_prime_pow`, `sigmaStar_prime`),
needed to unblock the `omega_odd_le_two_adic_add_one` structural bound
toward Erdős #1052 (genuinely open: are there finitely many unitary
perfect numbers?). Delegated to a subagent with a deliberately bounded
scope: transport ONLY the two prime/prime-power special cases
(`sigmaStar_prime_pow`, `sigmaStar_prime`, plus their `uDiv`/`sigmaStar`/
`mem_uDiv` dependencies), explicitly excluding `sigmaStar_mul_of_coprime`
(a 5-branch `Finset.sum_nbij'` with nested bullet case splits — a
substantially bigger bullet-free rewrite job) and
`omega_odd_le_two_adic_add_one` (which depends on it), matching this
lane's established incremental-transport practice (see
`erdos_1052_proper_eq_erase.v1`'s own notes on the same pattern).

Added `packets/frontier/erdos/erdos_1052_sigmastar_prime_pow_and_prime.v1.json`:
`SubmitModule` with 2 defs (`uDiv`, `sigmaStar`) + 2 helper theorems
(`mem_uDiv`, `sigmaStar_prime_pow`) + root theorem `sigmaStar_prime`,
kernel_verified on the FIRST attempt (episode
`0eb1d5e8-4af9-4980-930c-52979b3e5cc9`, problem_version
`ae154ca2-2f0a-4000-9324-bf3ef48af1e4`, dev-attested), independently
re-verified in this repo's own pinned toolchain rather than trusted from
the sibling repo's already-kernel_verified status. `training.eligibility:
quarantined` per the default-quarantine policy for `open_problem_related`
packets, matching every other packet in this lane. The sibling source's
`sigmaStar_prime_pow` proof used nested `.`-bullet case splits; rewritten
entirely bullet-free (bare sequential tactics per branch) plus proactive
parenthesization of every `have h := by tac1; tac2` followed by sibling
tactics (issue #67's flattened-sequence trap) — no other mathematical
content changed from the sibling source. Updated
`packets/frontier/erdos/COMPANION_RESULTS.md`'s row to reflect the
packetized pieces and re-flag `sigmaStar_mul_of_coprime` +
`omega_odd_le_two_adic_add_one` as the still-open priority target for a
future cycle.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; full corpus revalidated clean at 330 packets,
0 errors, 0 warnings (302 verified public + 28 negative per
`corpus_stats.py`, 120.8% of the 250-packet v0.1 public target). Commit
scoped to only this cycle's own files.

## Proposed update — inequalities elementary packet: general_amgm (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained comfortably exceeded. Swept every elementary domain's
`QUEUE.md` — all genuinely drained, including this agent's own prior
`erdos_1052` chain's next piece (`sum_uDiv_factor`, blocked on a 120s
timeout, recorded in `packets/frontier/erdos/BLOCKERS.md`, deliberately
not re-attempted blind this cycle). Reconsidered
`packets/elementary/inequalities/QUEUE.md`'s deferred "General n-term
AM-GM" backlog item (previously assumed to need new
`InequalityEstimateKit` infrastructure) and checked via
`mathlib_search_declarations` whether Mathlib already has this —
it does: `Real.geom_mean_le_arith_mean_weighted`, the weighted AM-GM for
Finsets.

Added `packets/elementary/inequalities/general_amgm.v1.json`: for
nonempty finite `s` and nonneg `z : ι → ℝ`, `(∏ z i)^(1/|s|) ≤ (∑ z
i)/|s|`, derived by instantiating the weighted lemma with constant
weights `1/|s|` and collapsing via `Real.finsetProd_rpow` +
`Finset.mul_sum`. Produced via tracked episode
`71fafcd9-0ab6-4498-b785-b8bd96d5dc5a` (problem_version
`17158be0-69fc-4443-9b32-6b20dd3bc537`, dev-attested,
`problem_imports: ["Mathlib"]`), `kernel_verified` on the second attempt
(step 1 failed on the unqualified name — the lemma lives under the
`Real` namespace in this Mathlib rev). Closes the backlog item outright:
no new kit was needed, just the right existing Mathlib lemma.

Schema-validated (`validate_packets.py --check-hashes --warn-as-error`:
0 errors) and hash-stamped; commit `d4784ca`, scoped to only these two new
files. Full `packets/elementary/inequalities/` revalidated clean at 30
packets, 0 errors, 0 warnings; full corpus at 303 verified public + 28
negative (121.2% of the v0.1 public target) as of this update.

## Proposed update — induction: sum_consec_product packet (this agent, 2026-07-08)

Priority-3 elementary work this cycle (no blocking bugs; no zero-coverage
negative lane; functions/induction/inequalities were tied lowest at 30
packets each, but functions' `QUEUE.md` explicitly states every focus
topic already has multiple packets, and inequalities has a concurrent
agent actively authoring its one remaining backlog item
(`general_amgm`, seen in-flight as untracked files this cycle — left
untouched). Induction's own `QUEUE.md` invites self-deriving a target
from `LOOP.md`'s domain focus when the backlog is empty, same as last
cycle's `exists_prime_factorization`.

Picked the tetrahedral-number formula (sum of the first n triangular
numbers, stated division-free as `3 * sum_{k<n} (k+1)*(k+2) =
n*(n+1)*(n+2)`) — a genuine gap one rung above the domain's existing
power sums (`gauss_sum`/`sum_squares`/`sum_cubes`, degrees 1-3) and
`arith_seq_sum`'s general arithmetic series, using the same
multiply-through-to-avoid-division trick `arith_seq_sum` already
established in this domain. Confirmed via grep that no existing packet
anywhere in the corpus covers triangular/tetrahedral numbers before
authoring.

Kernel-verified on the FIRST attempt (tracked episode
`1db4baa6-e5da-4a20-956c-614b960aabcc`): plain induction, `Finset.sum_range_succ`
+ `Nat.mul_add` + substituting the inductive hypothesis + `ring`. No
issues hit this time (a pleasant contrast to last cycle's 4-attempt
`exists_prime_factorization`).

Authored `packets/elementary/induction/sum_consec_product.v1.json` +
`lean/MathCorpus/Elementary/Induction/SumConsecProduct.lean`, stamped
hashes, validated clean (332 packets, 0 errors, 0 warnings). Updated
`DASHBOARD.md`/`QUEUE.md` in `packets/elementary/induction/`. Committed
only this cycle's own files, pathspec-scoped.

## Proposed update — inequalities: am_hm_two packet + stale-queue fix (this agent, 2026-07-08)

Priority-3 elementary work this cycle (no blocking bugs; no zero-coverage
negative lane; functions/inequalities/induction were the lowest three
domains). Functions' `QUEUE.md` explicitly states every focus-list topic
is already covered — confirmed genuinely dry, skipped. Inequalities'
`QUEUE.md` still listed "General n-term AM-GM" as an open backlog item,
but a concurrent agent had already landed it this session
(`general_amgm.v1`, episode `71fafcd9-0ab6-4498-b785-b8bd96d5dc5a`,
commit `d4784ca`) — the same stale-queue pattern hit with geometry's
`law_of_cosines` two cycles ago. Reconciled `QUEUE.md` to mark it done.

With the queue now genuinely empty, self-derived a fresh target from the
domain's power-mean focus: this corpus already has `qm_am_bound`/
`three_var_qm_am_bound` (QM-AM) and `am_gm_two`/`am_gm_four_term`/
`three_var_am_gm`/`general_amgm` (AM-GM), completing most of the
QM >= AM >= GM >= HM chain — but nothing for AM-HM. Confirmed via grep
(no "harmonic" hits anywhere in `packets/elementary/inequalities/`)
before authoring `am_hm_two`: `2/(1/a+1/b) <= (a+b)/2` for positive a, b.

Took 2 tracked attempts (episode `62654695-cd9d-4331-9466-55ad49a5c5f3`):
the first used `div_le_div_iff`, which doesn't exist under that bare
name in this Mathlib revision — it's been renamed `div_le_div_iff₀` as
part of a broader GroupWithZero-generalization naming pattern (sibling
names like `div_le_div_iff_of_pos_left` exist too).
`mathlib_search_declarations` surfaced the correct current name
immediately, and the proof (`div_add_div` + `div_div_eq_mul_div` +
`div_le_div_iff₀` + `nlinarith [sq_nonneg (a-b)]`) went through on the
second attempt.

Authored `packets/elementary/inequalities/am_hm_two.v1.json` +
`lean/MathCorpus/Elementary/Inequalities/AmHmTwo.lean`, stamped hashes,
validated clean (333 packets, 0 errors, 0 warnings). Updated
`DASHBOARD.md`/`QUEUE.md` in `packets/elementary/inequalities/`.
Committed only this cycle's own files, pathspec-scoped.

## Proposed update — formal_conjectures Arxiv/ triage, round 4 (this agent, 2026-07-08, /loop continuation)

Startup this cycle: no bugs/triage; both v0.1 numeric release criteria
remained comfortably exceeded. Swept every elementary domain's
`QUEUE.md` — algebra, number_theory, combinatorics all now confirm
genuinely empty `Next targets`/`Backlog` (Bezout landed in
number_theory since this agent's last check, closing that domain's queue
too). This agent's own `erdos_1052` chain remains blocked on
`sum_uDiv_factor`'s 120s timeout (recorded last cycle, not re-attempted).

Continued the ongoing `packets/frontier/formal_conjectures/` survey
(rounds 1-3 by other concurrent agents covered Millennium/Hilbert/Books/
OpenQuantumProblems/Mathoverflow/Other) with round 4: `Arxiv/`. Corrected
the file count to 14 (not the 9 originally estimated — the estimate only
counted files with a `research solved` tag, missing several
`research open`-only files). Checked every `research solved`-tagged file
(11 of 14) for a bare `sorry` vs. a real proof: **0/11 yield a
transportable win** — every single `research solved` theorem body in the
whole category is `sorry`, the highest sorry-rate of any category triaged
so far (rounds 1-3 each found at least one proof-complete candidate). Two
files (`0911.2077/Conjecture6_3.lean`, `1308.0994/BoxdotConjecture.lean`)
additionally have unreplayed external `formal_proof` links, the same
"linked but not verified here" pattern as `#1052`'s AlphaProof link.

No proof-search episode run this cycle (dossier-only, no proof claims).
No packet JSON touched. Files updated:
`packets/frontier/formal_conjectures/{SOURCE_MAP.md,SOLVED_QUEUE.md}`
(commit `4aaa98b`). `Arxiv/` is now fully triaged with zero candidates;
`OEIS/` (7 files) is the smallest remaining untriaged category for a
future cycle.
