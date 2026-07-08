import Mathlib
/-!
# The fundamental counting principle for Cartesian products

Packet: `elementary.combinatorics.card_product.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The number of pairs in the Cartesian product of two finite sets equals the product of their individual sizes — the fundamental counting principle.
Kernel-verified through the tracked proof-search loop (episode 04430956).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_product' (s t : Finset ℕ) : (s ×ˢ t).card = s.card * t.card := by
  exact Finset.card_product s t

end MathCorpus.Elementary.Combinatorics
