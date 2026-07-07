import Mathlib
/-!
# Membership in Finset.range

Packet: `elementary.combinatorics.mem_range.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

m belongs to {0, ..., n-1} exactly when m < n.
Kernel-verified through the tracked proof-search loop (episode 5f3f85a1).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem mem_range' (n m : ℕ) : m ∈ Finset.range n ↔ m < n := by
  exact Finset.mem_range

end MathCorpus.Elementary.Combinatorics
