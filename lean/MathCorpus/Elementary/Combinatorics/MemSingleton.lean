import Mathlib
/-!
# Membership in a singleton

Packet: `elementary.combinatorics.mem_singleton.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

An element is in a singleton finite set exactly when it equals the element.
Kernel-verified through the tracked proof-search loop (episode 480be260).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem mem_singleton' (a b : ℕ) : a ∈ ({b} : Finset ℕ) ↔ a = b := by
  exact Finset.mem_singleton

end MathCorpus.Elementary.Combinatorics
