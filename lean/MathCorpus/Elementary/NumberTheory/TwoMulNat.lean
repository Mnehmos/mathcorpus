import Mathlib
/-!
# Two times n is n plus n

Packet: `elementary.number_theory.two_mul_nat.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For every natural n, 2n = n + n.
Kernel-verified through the tracked proof-search loop (episode 2c6c7d90).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem two_mul_nat (n : ℕ) : 2 * n = n + n := by
  exact two_mul n

end MathCorpus.Elementary.NumberTheory
