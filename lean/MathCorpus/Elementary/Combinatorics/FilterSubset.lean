import Mathlib
/-!
# A filtered set is a subset

Packet: `elementary.combinatorics.filter_subset.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

Filtering a finite set by a predicate yields a subset of the original.
Kernel-verified through the tracked proof-search loop (episode 5140abfa).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem filter_subset' (s : Finset ℕ) : s.filter (fun x => x % 2 = 0) ⊆ s := by
  exact Finset.filter_subset _ s

end MathCorpus.Elementary.Combinatorics
