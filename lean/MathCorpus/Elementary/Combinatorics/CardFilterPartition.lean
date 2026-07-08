import Mathlib
/-!
# A predicate and its negation partition a finite set's cardinality

Packet: `elementary.combinatorics.card_filter_partition.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

Partitioning a finite set by a predicate (here, evenness) and its negation always accounts for every element exactly once: the two filtered cardinalities sum to the whole set's cardinality.
Kernel-verified through the tracked proof-search loop (episode 5229559a).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem card_filter_partition (s : Finset ℕ) : (s.filter (fun a => a % 2 = 0)).card + (s.filter (fun a => ¬ (a % 2 = 0))).card = s.card := by
  exact Finset.card_filter_add_card_filter_not _

end MathCorpus.Elementary.Combinatorics
