import Mathlib
/-!
# The empty set is a right identity for union

Packet: `elementary.combinatorics.union_empty.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The empty set is a right identity for union.
Kernel-verified through the tracked proof-search loop (episode d5ab653b).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem union_empty : ∀ (s : Finset ℕ), s ∪ ∅ = s := by
  intro s; exact Finset.union_empty s

end MathCorpus.Elementary.Combinatorics
