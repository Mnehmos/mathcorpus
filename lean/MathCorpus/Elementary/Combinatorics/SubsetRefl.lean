import Mathlib
/-!
# Subset is reflexive

Packet: `elementary.combinatorics.subset_refl.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

Every finite set is a subset of itself.
Kernel-verified through the tracked proof-search loop (episode 3b39e28d).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem subset_refl' (s : Finset ℕ) : s ⊆ s := by
  exact Finset.Subset.refl s

end MathCorpus.Elementary.Combinatorics
