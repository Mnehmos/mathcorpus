import Mathlib
/-!
# 4n is never prime

Packet: `elementary.number_theory.four_mul_not_prime.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

For every natural n, 4*n is not prime: n=0 gives 0 (not prime), and n>=1
gives an even number >=4 with the proper factor 2, so it cannot be prime.
Kernel-verified through the tracked proof-search loop (episode 3148ceed).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem four_mul_not_prime (n : ℕ) : ¬ Nat.Prime (4 * n) := by
  intro hp
  have h2 : (2 : ℕ) ∣ 4 * n := ⟨2 * n, by ring⟩
  have h3 := hp.eq_one_or_self_of_dvd 2 h2
  omega

end MathCorpus.Elementary.NumberTheory
