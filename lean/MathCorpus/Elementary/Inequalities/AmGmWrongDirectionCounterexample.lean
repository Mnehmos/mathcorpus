import Mathlib
/-!
# AM-GM flipped-direction counterexample

Packet: `elementary.inequalities.amgm_wrong_direction_counterexample.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

The flipped-direction claim `(a+b)/2 <= sqrt(a*b)` (AM-GM actually says
`>=`) is false in general: witness a=1, b=9 gives (1+9)/2 = 5 > 3 =
sqrt(1*9). Companion to the negative example
negative.inequalities.amgm_wrong_direction_bare_nlinarith_failure.v1.
Kernel-verified through the tracked proof-search loop (episode 5c239fdd).
-/

namespace MathCorpus.Elementary.Inequalities

theorem amgm_wrong_direction_counterexample :
    ∃ (a b : ℝ), a > 0 ∧ b > 0 ∧ (a + b) / 2 > Real.sqrt (a * b) := by
  refine ⟨1, 9, by norm_num, by norm_num, ?_⟩
  rw [show (1:ℝ) * 9 = 3 ^ 2 by norm_num, Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 3)]
  norm_num

end MathCorpus.Elementary.Inequalities
