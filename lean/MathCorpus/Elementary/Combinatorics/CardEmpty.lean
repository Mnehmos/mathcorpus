import Mathlib
/-!
# The empty finite set has cardinality zero

Packet: `elementary.combinatorics.card_empty.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The empty finite set has cardinality zero.
Kernel-verified through the tracked proof-search loop (episode 654b96f8).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_empty : (∅ : Finset ℕ).card = 0 := by
  exact Finset.card_empty

end MathCorpus.Elementary.Combinatorics
