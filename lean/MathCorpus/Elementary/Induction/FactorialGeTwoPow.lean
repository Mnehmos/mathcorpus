import Mathlib
/-!
# Factorial dominates 2^n

Packet: `elementary.induction.factorial_ge_two_pow.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural number n, 2 ^ n <= (n + 1)!. Equivalent, via n -> n - 1, to the
more commonly stated "n! >= 2 ^ (n - 1) for n >= 1"; phrased with a shift by one to
avoid Nat truncated subtraction entirely.
Kernel-verified through the tracked proof-search loop (episode 538ea8b6).
-/

namespace MathCorpus.Elementary.Induction

theorem factorial_ge_two_pow : ∀ n : ℕ, 2 ^ n ≤ Nat.factorial (n + 1) := by
  intro n
  induction n with
  | zero => norm_num [Nat.factorial]
  | succ n ih =>
    rw [Nat.factorial_succ, pow_succ]
    nlinarith [ih, Nat.factorial_pos (n + 1)]

end MathCorpus.Elementary.Induction
