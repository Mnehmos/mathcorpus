import Mathlib
/-!
# n is even iff n^2 is even

Packet: `elementary.number_theory.even_sq.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

The classic fact used in the standard irrationality-of-sqrt-2 proof pattern:
Even (n ^ 2) ↔ Even n.
Kernel-verified through the tracked proof-search loop (episode 5bbacd66).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem even_sq (n : ℕ) : Even (n ^ 2) ↔ Even n := by
  exact Nat.even_pow' (by norm_num)

end MathCorpus.Elementary.NumberTheory
