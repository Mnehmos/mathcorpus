import Mathlib
/-!
# A sum over the empty finite set is zero

Packet: `elementary.combinatorics.sum_empty.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

A sum over the empty finite set is zero.
Kernel-verified through the tracked proof-search loop (episode 522ea926).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem sum_empty : ∀ (f : ℕ → ℕ), (∑ i ∈ (∅ : Finset ℕ), f i) = 0 := by
  intro f; simp

end MathCorpus.Elementary.Combinatorics
