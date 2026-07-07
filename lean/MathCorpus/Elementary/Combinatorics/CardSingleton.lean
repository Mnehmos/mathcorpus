import Mathlib
/-!
# Cardinality of a singleton

Packet: `elementary.combinatorics.card_singleton.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

A singleton finite set has exactly one element.
Kernel-verified through the tracked proof-search loop (episode 26f44454).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_singleton' (a : ℕ) : ({a} : Finset ℕ).card = 1 := by
  exact Finset.card_singleton a

end MathCorpus.Elementary.Combinatorics
