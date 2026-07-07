import Mathlib
/-!
# Every integer is even or odd

Packet: `elementary.number_theory.even_or_odd.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

Every integer is either even or odd.
Kernel-verified through the tracked proof-search loop (episode 1a94185f).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem even_or_odd' (n : ℤ) : Even n ∨ Odd n := by
  exact Int.even_or_odd n

end MathCorpus.Elementary.NumberTheory
