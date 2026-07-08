import Mathlib
/-!
# Intersection with the empty set on the right is empty

Packet: `elementary.combinatorics.inter_empty.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

Intersection with the empty set on the right is empty.
Kernel-verified through the tracked proof-search loop (episode 85df4b0e).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem inter_empty : ∀ (s : Finset ℕ), s ∩ ∅ = ∅ := by
  intro s; exact Finset.inter_empty s

end MathCorpus.Elementary.Combinatorics
