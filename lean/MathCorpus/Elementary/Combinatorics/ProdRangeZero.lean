import Mathlib
/-!
# A product over an empty range is one

Packet: `elementary.combinatorics.prod_range_zero.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

A product over an empty range is one.
Kernel-verified through the tracked proof-search loop (episode 37e7d706).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem prod_range_zero : ∀ (f : ℕ → ℕ), (∏ i ∈ Finset.range 0, f i) = 1 := by
  intro f; simp

end MathCorpus.Elementary.Combinatorics
