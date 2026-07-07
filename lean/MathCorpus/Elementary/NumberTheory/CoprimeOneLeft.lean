import Mathlib
/-!
# One is coprime to everything

Packet: `elementary.number_theory.coprime_one_left.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

One is coprime to every natural number.
Kernel-verified through the tracked proof-search loop (episode 513069db).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem coprime_one_left' (n : ℕ) : Nat.Coprime 1 n := by
  exact Nat.coprime_one_left n

end MathCorpus.Elementary.NumberTheory
