import Mathlib
/-!
# Bernoulli's inequality

Packet: `elementary.induction.bernoulli_inequality.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every real x with x >= -1 and every natural number n, 1 + n*x <= (1 + x)^n (Bernoulli's inequality).
Kernel-verified through the tracked proof-search loop (episode 344364cb).
-/

namespace MathCorpus.Elementary.Induction

theorem bernoulli_inequality (n : ℕ) (x : ℝ) (hx : -1 ≤ x) : 1 + (n : ℝ) * x ≤ (1 + x) ^ n := by
  induction n with
  | zero => norm_num
  | succ n ih =>
    have hx' : (0:ℝ) ≤ 1 + x := by linarith
    rw [pow_succ]
    push_cast
    nlinarith [mul_le_mul_of_nonneg_right ih hx', sq_nonneg x]

end MathCorpus.Elementary.Induction
