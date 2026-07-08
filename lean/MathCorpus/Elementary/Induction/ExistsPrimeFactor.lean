import Mathlib
/-!
# Every n >= 2 has a prime factor, by strong induction

Packet: `elementary.induction.exists_prime_factor.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Every natural number n >= 2 has a prime factor: there exists a prime p dividing n.
Kernel-verified through the tracked proof-search loop (episode ac1ea7d4).
-/

namespace MathCorpus.Elementary.Induction

theorem exists_prime_factor (n : ℕ) (hn : 2 ≤ n) : ∃ p, Nat.Prime p ∧ p ∣ n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    by_cases hp : n.Prime
    · exact ⟨n, hp, dvd_refl n⟩
    · obtain ⟨m, hm_dvd, hm2, hm_lt⟩ := Nat.exists_dvd_of_not_prime2 hn hp
      obtain ⟨p, hp_prime, hp_dvd⟩ := ih m hm_lt hm2
      exact ⟨p, hp_prime, hp_dvd.trans hm_dvd⟩

end MathCorpus.Elementary.Induction
