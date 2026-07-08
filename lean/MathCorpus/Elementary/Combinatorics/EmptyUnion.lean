import Mathlib
/-!
# The empty set is a left identity for union

Packet: `elementary.combinatorics.empty_union.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The empty set is a left identity for union.
Kernel-verified through the tracked proof-search loop (episode 125ef41e).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem empty_union : ∀ (s : Finset ℕ), ∅ ∪ s = s := by
  intro s; exact Finset.empty_union s

end MathCorpus.Elementary.Combinatorics
