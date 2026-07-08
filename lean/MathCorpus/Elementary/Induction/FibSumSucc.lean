import Mathlib
/-!
# Fibonacci partial-sum identity

Packet: `elementary.induction.fib_sum_succ.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

The sum of the first n Fibonacci numbers plus 1 equals fib (n+1):
(fib 0 + fib 1 + ... + fib (n-1)) + 1 = fib (n+1). Phrased additively to avoid
Nat truncated subtraction.
Kernel-verified through the tracked proof-search loop (episode fe47cf48).
-/

namespace MathCorpus.Elementary.Induction

theorem fib_sum_succ : ∀ n : ℕ, (∑ i ∈ Finset.range n, Nat.fib i) + 1 = Nat.fib (n + 1) := by
  intro n
  induction n with
  | zero => simp [Nat.fib]
  | succ k ih =>
    rw [Finset.sum_range_succ, Nat.fib_add_two]
    omega

end MathCorpus.Elementary.Induction
