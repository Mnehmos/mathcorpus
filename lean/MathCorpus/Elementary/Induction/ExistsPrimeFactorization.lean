import Mathlib
/-!
# Every n >= 1 is a product of primes, by strong induction

Packet: `elementary.induction.exists_prime_factorization.v1`
Level:  L1_proof_basics · Domain: induction · Trust rung 1 (Lean kernel).

Every natural number n >= 1 can be written as a product of a (possibly
empty) list of prime numbers -- existence half of the fundamental
theorem of arithmetic, proved by strong induction via the minimal prime
factor (`Nat.minFac`). Extends `exists_prime_factor` (existence of A
prime factor) to a full factorization.
Kernel-verified through the tracked proof-search loop (episode f53c8d62).
-/

namespace MathCorpus.Elementary.Induction

theorem exists_prime_factorization :
    ∀ n : ℕ, 1 ≤ n → ∃ l : List ℕ, (∀ p ∈ l, Nat.Prime p) ∧ l.prod = n := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro hn
    by_cases hn1 : n = 1
    · exact ⟨[], by simp, by simp [hn1]⟩
    · have hp : (n.minFac).Prime := Nat.minFac_prime hn1
      have hdvd : n.minFac ∣ n := Nat.minFac_dvd n
      have hlt : n / n.minFac < n := Nat.div_lt_self (by omega) hp.one_lt
      have hpos : 1 ≤ n / n.minFac := Nat.div_pos (Nat.minFac_le (by omega)) hp.pos
      obtain ⟨l, hl1, hl2⟩ := ih (n / n.minFac) hlt hpos
      refine ⟨n.minFac :: l, ?_, ?_⟩
      · intro q hq
        rcases List.mem_cons.mp hq with rfl | hq
        exacts [hp, hl1 q hq]
      · rw [List.prod_cons, hl2]
        exact Nat.mul_div_cancel' hdvd

end MathCorpus.Elementary.Induction
