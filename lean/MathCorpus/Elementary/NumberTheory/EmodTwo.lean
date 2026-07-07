import Mathlib
/-!
# An integer is 0 or 1 mod 2

Packet: `elementary.number_theory.emod_two.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

Every integer leaves remainder 0 or 1 upon division by 2.
Kernel-verified through the tracked proof-search loop (episode 7030ea27).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem emod_two (n : ℤ) : n % 2 = 0 ∨ n % 2 = 1 := by
  omega

end MathCorpus.Elementary.NumberTheory
