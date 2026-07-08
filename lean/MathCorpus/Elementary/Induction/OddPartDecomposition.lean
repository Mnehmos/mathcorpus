import Mathlib
/-!
# Every positive natural number is 2^k times an odd number

Packet: `elementary.induction.odd_part_decomposition.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Every positive natural number n can be written as 2^k * m for some k and some odd m -- the 2-adic valuation decomposition.
Kernel-verified through the tracked proof-search loop (episode ce2bb257).
-/

namespace MathCorpus.Elementary.Induction

theorem odd_part_decomposition (n : ℕ) (hn : 0 < n) : ∃ k m : ℕ, Odd m ∧ n = 2 ^ k * m := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases Nat.even_or_odd n with he | ho
    · obtain ⟨r, hr⟩ := he
      have hr0 : 0 < r := by omega
      have hrn : r < n := by omega
      obtain ⟨k, m, hm, hkm⟩ := ih r hrn hr0
      exact ⟨k + 1, m, hm, by rw [hr, hkm]; ring⟩
    · exact ⟨0, n, ho, by ring⟩

end MathCorpus.Elementary.Induction
