import Mathlib
/-!
# Factorial positivity, by induction

Packet: `elementary.induction.factorial_pos_induction.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, n! > 0. Proved by genuine induction (not citation) --
distinct from packets/elementary/number_theory/factorial_pos.v1, which is a
one-line Nat.factorial_pos citation; this is the induction-technique version of
the same fact, aimed at offsetting this domain's L0_elementary/L1_proof_basics
level-distribution skew.
Kernel-verified through the tracked proof-search loop (episode d6963e91).
-/

namespace MathCorpus.Elementary.Induction

theorem factorial_pos_induction (n : ℕ) : 0 < Nat.factorial n := by
  induction n with
  | zero => norm_num [Nat.factorial]
  | succ k ih => rw [Nat.factorial_succ]; exact Nat.mul_pos (Nat.succ_pos k) ih

end MathCorpus.Elementary.Induction
