import Mathlib
/-!
# 2^n exceeds n^2 from n = 5 onward

Packet: `elementary.induction.two_pow_gt_sq_from_five.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n >= 5, 2^n > n^2. This statement is false for
n in {2,3,4} (2^4 = 16 = 4^2, not >), so the induction must start at the
threshold n = 5, not at n = 0.
Kernel-verified through the tracked proof-search loop (episode 1fea172d).
-/

namespace MathCorpus.Elementary.Induction

theorem two_pow_gt_sq_from_five (n : ℕ) (h : n ≥ 5) : 2 ^ n > n ^ 2 := by
  induction n, h using Nat.le_induction with
  | base => norm_num
  | succ n hn ih => rw [pow_succ]; nlinarith [ih, hn, sq_nonneg n]

end MathCorpus.Elementary.Induction
