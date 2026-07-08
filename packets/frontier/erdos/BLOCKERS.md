# Blockers — Erdős Frontier

| Date | Target | Blocker | Route Attempted | Status |
|------|--------|---------|------------------|--------|
| 2026-07-08 | `#1113` Sierpiński (infinitely many Sierpiński numbers), `ErdosProblems/erdos-1113/proof/Erdos1113_infinitely_many_sierpinski.lean` | The sibling repo's own proof needs `set_option maxHeartbeats 4000000 in` on its main lemma (a `decide` over 36 residues x a 7-element covering list, plus `fin_cases`/`nlinarith` case work) — `episode_step`'s `submit_module` action explicitly forbids client-submitted `set_option` lines ("clients send structured items only... no import/namespace/end/set_option lines"), so this proof cannot be transported as-is via `SubmitModule`. Not attempted via `Solve` either (same underlying heartbeat need). | Not started — `problem_create`/`episode_create` never called | **Do not re-attempt via SubmitModule without a workaround** (e.g. restructuring to avoid the heavy `decide`, or checking whether `episode_create`/`problem_create` exposes a per-problem heartbeat budget this session didn't discover) — record any new finding here rather than re-discovering this from scratch. |

Do not auto-fire repeatedly at a known frontier blocker. If a target
stalls, record the blocker here and stop.
