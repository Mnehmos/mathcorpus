import Mathlib
/-!
# A successor is positive

Packet: `elementary.number_theory.succ_pos.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The successor of any natural number is positive.
Kernel-verified through the tracked proof-search loop (episode a8fd9341).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem succ_pos' (n : ℕ) : 0 < n + 1 := by
  exact Nat.succ_pos n

end MathCorpus.Elementary.NumberTheory
