import Mathlib

/-!
# Factorial grows faster than power of 2 for n >= 4

Packet: `number_theory.induction.two_pow_le_factorial_four.v1`
Level:  L2_olympiad · Domain: number_theory · Trust rung 1 (Lean kernel).

For any natural number n >= 4, 2^n <= n!.
-/

namespace MathCorpus.Olympiad.NumberTheory

theorem two_pow_le_factorial_four' : ∀ (n : ℕ), 4 ≤ n → 2 ^ n ≤ Nat.factorial n := by
  intro n hn
  induction hn with
  | refl => decide
  | step hd ih =>
    rename_i m
    have hm : 2 ≤ m + 1 := Nat.le_trans (by decide) (Nat.le_succ_of_le hd)
    have hstep : 2 * 2 ^ m ≤ (m + 1) * Nat.factorial m := Nat.mul_le_mul hm ih
    rw [pow_succ', Nat.factorial_succ]
    exact hstep

end MathCorpus.Olympiad.NumberTheory
