import Mathlib
/-!
# Three-term QM-AM style bound

Packet: `elementary.inequalities.three_var_qm_am_bound.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all reals a, b, c: (a+b+c)^2 <= 3*(a^2+b^2+c^2), a three-term QM-AM style bound.
Kernel-verified through the tracked proof-search loop (episode 15f8194a).
-/

namespace MathCorpus.Elementary.Inequalities

theorem three_var_qm_am_bound (a b c : ℝ) : (a + b + c) ^ 2 ≤ 3 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (a - c)]

end MathCorpus.Elementary.Inequalities
