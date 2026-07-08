import Mathlib
/-!
# AM-HM inequality (two-term case)

Packet: `elementary.inequalities.am_hm_two.v1`
Level:  L1_proof_basics · Domain: inequalities · Trust rung 1 (Lean kernel).

For positive reals a, b, the harmonic mean 2/(1/a+1/b) is at most the
arithmetic mean (a+b)/2 -- completing this domain's power-mean chain
(QM >= AM >= GM >= HM) alongside `qm_am_bound`/`am_gm_two`.
Kernel-verified through the tracked proof-search loop (episode 62654695).
-/

namespace MathCorpus.Elementary.Inequalities

theorem am_hm_two (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    2 / (1 / a + 1 / b) ≤ (a + b) / 2 := by
  rw [div_add_div _ _ ha.ne' hb.ne', div_div_eq_mul_div,
    div_le_div_iff₀ (by positivity) (by norm_num)]
  nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Inequalities
