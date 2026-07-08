# Queue — Geometry (Negative Examples)

This domain already has 1 negative packet
(`angle_atoms_nlinarith_failure.v1.json`) — the only one in the corpus.
Add a second, **distinct** failure category rather than a near-duplicate.

## Next targets

- [ ] **Unguarded division by zero in a slope formula.** Attempt a slope
      identity `(y2 - y1) / (x2 - x1) = ...` without the hypothesis
      `x1 ≠ x2`. Expected failure mode: the statement is either false or
      vacuously ill-typed at `x1 = x2` (division by zero returns `0` in
      Lean's `Field`, which silently makes the "identity" false at that
      point) — a genuinely different category from the existing
      `nlinarith`-timeout example. gap_category: `false_generalization`,
      sub_category: `division_by_zero_unguarded`. Note the existing
      `perp_slopes_comm` packet for how the domain currently handles slope
      hypotheses, to avoid contradicting it.

## Backlog

- [ ] `field_simp`/`ring` mismatch on a coordinate-geometry goal mixing
      `EuclideanSpace` inner-product notation with raw coordinate algebra
      (verify a concrete instance before adding).
