import Mathlib
/-!
# Powers of two are at least 1

Packet: `elementary.induction.one_le_two_pow.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, 2^n is at least 1 -- powers of two are always positive (in fact >= 1).
Kernel-verified through the tracked proof-search loop (episode 5a603590).
-/

namespace MathCorpus.Elementary.Induction

theorem one_le_two_pow (n : ℕ) : 1 ≤ 2 ^ n := by
  induction n with
  | zero => norm_num
  | succ n ih => rw [pow_succ]; omega

end MathCorpus.Elementary.Induction
