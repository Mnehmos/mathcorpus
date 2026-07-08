import Mathlib
/-!
# Zero modulo any number is zero

Packet: `elementary.number_theory.zero_mod.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

Zero modulo any number is zero.
Kernel-verified through the tracked proof-search loop (episode e18a578f).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem zero_mod : ∀ (n : ℕ), 0 % n = 0 := by
  intro n; exact Nat.zero_mod n

end MathCorpus.Elementary.NumberTheory
