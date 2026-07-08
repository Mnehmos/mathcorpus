import Mathlib
/-!
# A successor is never zero

Packet: `elementary.number_theory.succ_ne_zero.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

A successor is never zero.
Kernel-verified through the tracked proof-search loop (episode d9a8931d).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem succ_ne_zero : ∀ (n : ℕ), n + 1 ≠ 0 := by
  intro n; exact Nat.succ_ne_zero n

end MathCorpus.Elementary.NumberTheory
