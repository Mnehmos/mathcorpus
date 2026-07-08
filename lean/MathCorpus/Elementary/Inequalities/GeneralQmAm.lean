import Mathlib
/-!
# General n-term QM-AM inequality (squared-sum form)

Packet: `elementary.inequalities.general_qm_am.v1`
Level:  L2_olympiad · Domain: inequalities · Trust rung 1 (Lean kernel).

For real-valued f on an arbitrary Finset s, (sum f_i)^2 <= |s| * (sum
f_i^2) -- the general n-term QM-AM inequality (Cauchy-Schwarz applied to
a constant-1 vector), extending `qm_am_bound`/`three_var_qm_am_bound`'s
fixed small arities to the general Finset case, mirroring `general_amgm`
and `general_cauchy_schwarz`.
Kernel-verified through the tracked proof-search loop (episode 0916c5cb).
-/

namespace MathCorpus.Elementary.Inequalities

theorem general_qm_am (ι : Type) (s : Finset ι) (f : ι → ℝ) :
    (∑ i ∈ s, f i) ^ 2 ≤ (s.card : ℝ) * ∑ i ∈ s, (f i) ^ 2 := by
  exact sq_sum_le_card_mul_sum_sq

end MathCorpus.Elementary.Inequalities
