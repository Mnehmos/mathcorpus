import Mathlib
/-!
# Intersection with the empty set on the left is empty

Packet: `elementary.combinatorics.empty_inter.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

Intersection with the empty set on the left is empty.
Kernel-verified through the tracked proof-search loop (episode 21724974).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem empty_inter : ∀ (s : Finset ℕ), ∅ ∩ s = ∅ := by
  intro s; exact Finset.empty_inter s

end MathCorpus.Elementary.Combinatorics
