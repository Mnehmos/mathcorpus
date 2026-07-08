import Mathlib
/-!
# A common divisor divides the difference

Packet: `elementary.number_theory.dvd_sub.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If k divides both m and n then k divides their (truncated) difference m - n.
Kernel-verified through the tracked proof-search loop (episode 9549fb69).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_sub' (k m n : ℕ) (h1 : k ∣ m) (h2 : k ∣ n) : k ∣ m - n := by
  exact Nat.dvd_sub h1 h2

end MathCorpus.Elementary.NumberTheory
