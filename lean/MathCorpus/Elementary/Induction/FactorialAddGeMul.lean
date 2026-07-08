import Mathlib
/-!
# (m+n)! is at least m! times n!

Packet: `elementary.induction.factorial_add_ge_mul.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every pair of natural numbers m, n: m! * n! <= (m+n)! (equivalently, the binomial coefficient C(m+n,n) = (m+n)!/(m!n!) is a positive integer).
Kernel-verified through the tracked proof-search loop (episode 01e983b5).
-/

namespace MathCorpus.Elementary.Induction

theorem factorial_add_ge_mul (m n : ℕ) : m.factorial * n.factorial ≤ (m + n).factorial := by
  induction n with
  | zero => simp
  | succ n ih =>
    have heq : m + (n + 1) = (m + n) + 1 := by ring
    rw [heq, Nat.factorial_succ, Nat.factorial_succ]
    have hpos : 0 < (m + n).factorial := Nat.factorial_pos (m + n)
    nlinarith [ih, hpos, Nat.mul_le_mul_left (n + 1) ih]

end MathCorpus.Elementary.Induction
