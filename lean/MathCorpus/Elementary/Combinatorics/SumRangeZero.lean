import Mathlib
/-!
# A sum over an empty range is zero

Packet: `elementary.combinatorics.sum_range_zero.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

A sum over an empty range is zero.
Kernel-verified through the tracked proof-search loop (episode 0b8f657f).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem sum_range_zero : ∀ (f : ℕ → ℕ), (∑ i ∈ Finset.range 0, f i) = 0 := by
  intro f; simp

end MathCorpus.Elementary.Combinatorics
