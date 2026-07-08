import Mathlib
/-!
# Strict less-than is irreflexive

Packet: `elementary.number_theory.lt_irrefl.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

No natural number is strictly less than itself.
Kernel-verified through the tracked proof-search loop (episode 8d1e09b2).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem lt_irrefl' (n : ℕ) : ¬ n < n := by
  exact lt_irrefl n

end MathCorpus.Elementary.NumberTheory
