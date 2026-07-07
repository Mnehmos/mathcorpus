import Mathlib
/-!
# Divisibility is transitive

Packet: `elementary.number_theory.dvd_trans.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For integers a, b, c, if a divides b and b divides c then a divides c.
Kernel-verified through the tracked proof-search loop (episode 711c9c24).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_trans' (a b c : ℤ) (hab : a ∣ b) (hbc : b ∣ c) : a ∣ c := by
  exact hab.trans hbc

end MathCorpus.Elementary.NumberTheory
