import Mathlib
/-!
# One divides everything

Packet: `elementary.number_theory.one_dvd.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

One divides every natural number.
Kernel-verified through the tracked proof-search loop (episode 177fe2fd).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem one_dvd' (n : ℕ) : 1 ∣ n := by
  exact one_dvd n

end MathCorpus.Elementary.NumberTheory
