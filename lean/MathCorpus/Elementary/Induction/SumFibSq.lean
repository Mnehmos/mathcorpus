import Mathlib
/-!
# Sum of squares of Fibonacci numbers

Packet: `elementary.induction.sum_fib_sq.v1`
Level:  L1_proof_basics · Domain: induction · Trust rung 1 (Lean kernel).

The sum of squares of the first n+1 Fibonacci numbers equals
fib(n)*fib(n+1) -- a classic Fibonacci identity, complementing the
domain's existing `fib_le_two_pow` (a growth bound) and `fib_sum_succ`
(the plain sum identity).
Kernel-verified through the tracked proof-search loop (episode 452d7bbe).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_fib_sq (n : ℕ) :
    (∑ i ∈ Finset.range (n + 1), (Nat.fib i) ^ 2) = Nat.fib n * Nat.fib (n + 1) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih, Nat.fib_add_two]
    ring

end MathCorpus.Elementary.Induction
