import Mathlib

/-!
# a divides lcm(a, b)

Packet: `elementary.number_theory.dvd_lcm_left.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

For all naturals a, b: a divides Nat.lcm a b. Pairs with `lcm_comm`.
Kernel-verified through the tracked proof-search loop (episode 2a1c9884).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_lcm_left' (a b : ℕ) : a ∣ Nat.lcm a b := Nat.dvd_lcm_left a b

end MathCorpus.Elementary.NumberTheory
