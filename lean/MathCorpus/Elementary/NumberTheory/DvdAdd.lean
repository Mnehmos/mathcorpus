import Mathlib

/-!
# Divisibility distributes over addition

Packet: `elementary.number_theory.dvd_add.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For integers a, b, c, if a divides b and a divides c then a divides b + c.
Kernel-verified through the tracked proof-search loop (episode ef40467c).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_add_of_dvd (a b c : ℤ) (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b + c) := by
  exact dvd_add hb hc

end MathCorpus.Elementary.NumberTheory
