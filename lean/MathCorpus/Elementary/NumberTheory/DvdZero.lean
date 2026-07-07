import Mathlib
/-!
# Everything divides zero

Packet: `elementary.number_theory.dvd_zero.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

Every natural number divides zero.
Kernel-verified through the tracked proof-search loop (episode 1558b038).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_zero' (n : ℕ) : n ∣ 0 := by
  exact dvd_zero n

end MathCorpus.Elementary.NumberTheory
