import Mathlib
/-!
# Multiplying back a quotient

Packet: `elementary.number_theory.mul_div_cancel.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If a divides b then multiplying a by the quotient b/a recovers b.
Kernel-verified through the tracked proof-search loop (episode 66c0439a).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem mul_div_cancel' (a b : ℕ) (h : a ∣ b) : a * (b / a) = b := by
  exact Nat.mul_div_cancel' h

end MathCorpus.Elementary.NumberTheory
