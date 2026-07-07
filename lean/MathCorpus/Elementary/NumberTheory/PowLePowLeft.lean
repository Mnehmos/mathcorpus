import Mathlib
/-!
# Power is monotone in the base

Packet: `elementary.number_theory.pow_le_pow_left.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If a ≤ b then a^n ≤ b^n for any fixed exponent n.
Kernel-verified through the tracked proof-search loop (episode 90e03222).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem pow_le_pow_left' (a b n : ℕ) (h : a ≤ b) : a ^ n ≤ b ^ n := by
  exact Nat.pow_le_pow_left h n

end MathCorpus.Elementary.NumberTheory
