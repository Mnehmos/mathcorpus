import Mathlib
/-!
# Two-variable AM-GM: 2ab ≤ a² + b²

Packet: `elementary.inequalities.two_mul_le_add_sq.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For all real a and b, 2ab ≤ a^2 + b^2.
Kernel-verified through the tracked proof-search loop (episode 0e9be1e1).
-/

namespace MathCorpus.Elementary.Inequalities

theorem two_mul_le_add_sq (a b : ℝ) : 2 * a * b ≤ a ^ 2 + b ^ 2 := by
  nlinarith [sq_nonneg (a - b)]

end MathCorpus.Elementary.Inequalities
