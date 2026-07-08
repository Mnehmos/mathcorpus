import Mathlib
/-!
# 2^n exceeds n

Packet: `elementary.induction.two_pow_gt_self.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, n is strictly less than 2 raised to the n (equivalently, 2^n > n).
Kernel-verified through the tracked proof-search loop (episode 5a175c43).
-/

namespace MathCorpus.Elementary.Induction

theorem two_pow_gt_self (n : ℕ) : n < 2 ^ n := by
  induction n with
  | zero => norm_num
  | succ n ih => rw [pow_succ]; nlinarith [ih]

end MathCorpus.Elementary.Induction
