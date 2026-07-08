import Mathlib
/-!
# b divides lcm(a, b)

Packet: `elementary.number_theory.dvd_lcm_right.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For every pair of naturals a, b: b ∣ Nat.lcm a b. Pairs with the already-authored
dvd_lcm_left (a ∣ Nat.lcm a b).
Kernel-verified through the tracked proof-search loop (episode b9c09daf).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_lcm_right' (a b : ℕ) : b ∣ Nat.lcm a b := by
  exact Nat.dvd_lcm_right a b

end MathCorpus.Elementary.NumberTheory
