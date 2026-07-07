import Mathlib
/-!
# Membership in an insertion

Packet: `elementary.combinatorics.mem_insert.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

An element is in insert b s exactly when it equals b or is already in s.
Kernel-verified through the tracked proof-search loop (episode c2196ad0).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem mem_insert' (a b : ℕ) (s : Finset ℕ) : a ∈ insert b s ↔ a = b ∨ a ∈ s := by
  exact Finset.mem_insert

end MathCorpus.Elementary.Combinatorics
