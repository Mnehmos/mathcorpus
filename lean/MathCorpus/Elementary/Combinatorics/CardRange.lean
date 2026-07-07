import Mathlib
/-!
# Cardinality of Finset.range

Packet: `elementary.combinatorics.card_range.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The finite set {0, 1, ..., n-1} has exactly n elements.
Kernel-verified through the tracked proof-search loop (episode 28c94a45).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_range' (n : ℕ) : (Finset.range n).card = n := by
  exact Finset.card_range n

end MathCorpus.Elementary.Combinatorics
