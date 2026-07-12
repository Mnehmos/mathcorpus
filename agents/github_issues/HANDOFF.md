# Handoff — Dev Issues

Session-to-session handoff notes for the dev loop agent. Update before
stopping a session; read at the start of the next one.

## Last session

- Date: 2026-07-12
- Issue worked: #7 (literature-lineage, idea-attribution, prior-art records) — done, see
  `DONE.md`. #1-#6 done earlier in the same continuous /loop run, prior entries.
- State left in: everything from #1-#6, plus 7 new `schema/mcip/v1/*.schema.json` files
  (`literature_source`, `retrieved_passage`, `external_claim`, `idea_attribution`,
  `prior_art_match`, `citation_review`, `contribution_statement`), matching
  `packet.schema.json` fields (`idea_attributions[]`, `prior_art_matches[]`,
  `citation_reviews[]`, `contribution_statements[]`), a new shared `literature_sources/`
  catalog (3 real entries) + `tools/stamp_literature_sources.py`,
  `tools/mathcorpus/policy.py` (`check_literature_lineage`, `check_literature_source_refs`,
  `check_literature_source_catalog`), a real enrichment of
  `packets/frontier/formal_conjectures/union_closed_sharpness.v1.json`, `ENUMS.md` docs.
  One cross-cutting fix: `schema/mcip/v1/_defs.schema.json` had an invalid
  `envelope_required` key (unused, zero references, failed strict `check_schema`) —
  removed. Committed locally on `main`. **Still not pushed** — same pre-existing
  ~220-commits-ahead-of-origin situation; push still needs explicit confirmation from the
  repo owner.
- Honest scope note carried into the issue #7 close-out comment: the acceptance criterion's
  named fixture ("CDC" with "prior Fano-flow work") doesn't exist anywhere in this repo —
  confirmed by search before starting. Substituted a real packet
  (`union_closed_sharpness.v1`) whose own pre-existing notes already had genuine literature
  provenance to enrich, rather than fabricate the named example. Also: `IdeaAttribution`'s
  Yu-2023 prior-art citation is explicitly marked bibliographically unverified (title/author
  taken from the packet's own pre-existing notes text, not an independently checked
  bibliography) — this repo's honesty standard extends to not overclaiming citation
  precision, not just not overclaiming proof results.
- Next step: #1-#7 are done. Only #8 (contribution/citation/novelty review policy) remains
  — read its full issue body fresh (`gh issue view 8 --repo Mnehmos/mathcorpus`) rather than
  the earlier triage summary. #8 is explicitly policy-layer, not new schema: it requires
  `ContributionStatement`/`CitationReview` (both now defined, #7) for open-problem/new-bound/
  counterexample/new-method packets, adds publication-readiness statuses
  (`metadata_only` … `publication_ready` / `blocked_missing_attribution` /
  `blocked_novelty_claim`), and must ensure kernel verification alone can never produce
  `publication_ready` for an open-problem claim. `union_closed_sharpness.v1` (open_problem_related:
  true, already has a real `contribution_statement`) is a natural fixture target — it should
  land somewhere short of `publication_ready` given the Yu-2023 novelty question is only
  `reviewer_confidence: 0.8`/unverified bibliography, which is exactly the kind of case #8's
  policy should catch. Once #8 lands, all 8 original roadmap issues are closed — that's a
  natural point to stop the loop and let the repo owner review/decide on pushing.
