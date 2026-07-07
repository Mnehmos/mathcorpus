import Mathlib
/-!
# Common divisor divides the gcd

Packet: `elementary.number_theory.dvd_gcd.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

Any common divisor of a and b divides gcd a b.
Kernel-verified through the tracked proof-search loop (episode c67b7f63).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem dvd_gcd' (a b c : ℕ) (hca : c ∣ a) (hcb : c ∣ b) : c ∣ Nat.gcd a b := by
  exact Nat.dvd_gcd hca hcb

end MathCorpus.Elementary.NumberTheory
