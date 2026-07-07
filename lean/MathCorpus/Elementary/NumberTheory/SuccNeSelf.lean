import Mathlib
/-!
# A successor is never equal to itself

Packet: `elementary.number_theory.succ_ne_self.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For every natural number n, n + 1 ≠ n.
Kernel-verified through the tracked proof-search loop (episode 8ca71d81).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem succ_ne_self' (n : ℕ) : n + 1 ≠ n := by
  exact Nat.succ_ne_self n

end MathCorpus.Elementary.NumberTheory
