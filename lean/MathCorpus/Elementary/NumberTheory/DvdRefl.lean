import Mathlib
/-!
# Divisibility is reflexive

Packet: `elementary.number_theory.dvd_refl.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

Every natural number divides itself.
Kernel-verified through the tracked proof-search loop (episode c6339a4e).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_refl' (n : ℕ) : n ∣ n := by
  exact dvd_refl n

end MathCorpus.Elementary.NumberTheory
