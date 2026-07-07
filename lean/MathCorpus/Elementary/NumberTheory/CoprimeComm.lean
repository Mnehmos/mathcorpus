import Mathlib
/-!
# Coprimality is symmetric

Packet: `elementary.number_theory.coprime_comm.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If a is coprime to b then b is coprime to a.
Kernel-verified through the tracked proof-search loop (episode fae1e9c9).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem coprime_comm' (a b : ℕ) (h : Nat.Coprime a b) : Nat.Coprime b a := by
  exact h.symm

end MathCorpus.Elementary.NumberTheory
