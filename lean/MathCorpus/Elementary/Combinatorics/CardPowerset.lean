import Mathlib
/-!
# The number of subsets of a finite set is 2 to the size

Packet: `elementary.combinatorics.card_powerset.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The number of subsets of a finite set (its powerset) equals 2 raised to the size of the set — a headline finite-combinatorics fact.
Kernel-verified through the tracked proof-search loop (episode 53929392).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_powerset' (s : Finset ℕ) : (Finset.powerset s).card = 2 ^ s.card := by
  exact Finset.card_powerset s

end MathCorpus.Elementary.Combinatorics
