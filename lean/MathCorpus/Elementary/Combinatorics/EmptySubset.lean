import Mathlib
/-!
# Empty set is a subset

Packet: `elementary.combinatorics.empty_subset.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The empty set is a subset of every finite set.
Kernel-verified through the tracked proof-search loop (episode 5e9a41a5).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem empty_subset' (s : Finset ℕ) : ∅ ⊆ s := by
  exact Finset.empty_subset s

end MathCorpus.Elementary.Combinatorics
