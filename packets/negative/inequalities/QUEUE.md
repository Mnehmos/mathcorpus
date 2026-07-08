# Queue — Inequalities (Negative Examples)

Negative examples are the biggest shortfall vs. the v0.1 release criteria
(~1/25 corpus-wide) — prioritize this lane highly. Candidates below are
hypotheses to verify via a real tracked episode, not pre-asserted facts.

## Next targets

- [ ] **nlinarith without hints on a three-variable symmetric inequality.**
      Attempt `nlinarith` (no hints) directly on `nesbitt_three_var` or
      `schur_degree_one` (see
      `packets/elementary/inequalities/QUEUE.md`) before those are
      authored as positive packets — record whichever fails first as the
      negative example, and only the other (or a cleaned-up version) as
      the positive packet. gap_category: `tactic_mismatch`, sub_category:
      `nlinarith_missing_sos_hint_three_var`.

## Backlog

- [ ] `polyrith`/`nlinarith` degree-mismatch: an inequality whose SOS
      certificate needs degree-4 terms that `nlinarith`'s default search
      depth doesn't reach (verify a concrete instance before adding).
