# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-12
- Issue worked: #8 (contribution/citation/novelty review policy) — done, see `DONE.md`.
  **This was the last issue in the 8-issue MCIP roadmap — #1-#8 are all closed.** #1-#7
  done earlier in the same continuous /loop run, prior entries.
- State left in: everything from #1-#7, plus `packet.schema.json` (`publication` object +
  `$defs.publication`), `tools/mathcorpus/policy.py`
  (`implicit_publication_status`, `check_publication_status`, plus the
  `citation_reviews[].supersedes` dangling-ref check that #7 had missed),
  `tools/mathcorpus/export.py` (`contribution_summary`, wired into both `public_row` and
  `negative_row`), a real `publication` field on
  `packets/frontier/formal_conjectures/union_closed_sharpness.v1.json`, `ENUMS.md` docs.
  Committed locally on `main`. **Still not pushed** — same pre-existing
  ~220-commits-ahead-of-origin situation from the start of this /loop run; push still needs
  explicit confirmation from the repo owner. 8 commits total for this roadmap:
  `7f1ac10`(#1) `8c74201`(#2) `bcdb683`(#3) `b3bfa63`(#4) `ed2e1a7`(#5) `928b2be`(#6)
  `ae51810`(#7) + this session's #8 commit.
- Honest scope note: `publication_ready` is gated (zero contribution_statements rejected;
  `open_problem_related` requires a current endorsed review; `contribution_class:
  "new_proof"` is blocked without one), but "strong novelty language" in *free text*
  (title/informal_statement wording) is not scanned — the check is structural
  (`contribution_class == "new_proof"`), not an NLP/keyword pass over prose. If a future
  reviewer wants free-text novelty-language detection too, that's a follow-up, not silently
  covered by this implementation.
- Next step: **the MCIP roadmap (#1-#8) is fully closed.** No more open issues in
  `Mnehmos/mathcorpus` as of this session (confirmed via `TRIAGE.md`). The dev loop's next
  session should: (1) re-check `gh issue list --repo Mnehmos/mathcorpus --state open` in
  case new issues have been filed since, (2) if none, there is nothing further for this
  loop to do until new issues arrive — do not invent new scope. The 8 local commits from
  this roadmap remain **unpushed**; surface that to the user/repo owner rather than pushing
  unilaterally, given the pre-existing large unpushed-commit backlog this session inherited.
