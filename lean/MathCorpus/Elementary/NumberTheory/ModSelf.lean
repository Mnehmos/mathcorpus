import Mathlib
/-!
# A number modulo itself is zero

Packet: `elementary.number_theory.mod_self.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

A number modulo itself is zero.
Kernel-verified through the tracked proof-search loop (episode 3a4539c1).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem mod_self : ∀ (n : ℕ), n % n = 0 := by
  intro n; exact Nat.mod_self n

end MathCorpus.Elementary.NumberTheory
