import Mathlib
/-!
# Well-ordering principle for the naturals

Packet: `elementary.number_theory.well_ordering.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

Every nonempty set of natural numbers has a least element.
Kernel-verified through the tracked proof-search loop (episode 96e95cc1).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem well_ordering (s : Set ℕ) (hs : s.Nonempty) : ∃ n ∈ s, ∀ m ∈ s, n ≤ m := by
  obtain ⟨n0, hn0⟩ := hs
  induction n0 using Nat.strong_induction_on with
  | _ n ih =>
    by_cases h : ∀ m ∈ s, n ≤ m
    · exact ⟨n, hn0, h⟩
    · push_neg at h
      obtain ⟨k, hk, hkn⟩ := h
      exact ih k hkn hk

end MathCorpus.Elementary.NumberTheory
