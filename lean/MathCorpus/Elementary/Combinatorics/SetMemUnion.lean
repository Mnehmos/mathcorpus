import Mathlib
/-!
# Set union membership

Packet: `elementary.combinatorics.set_mem_union.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

For any element a and sets s, t : Set alpha: a ∈ s ∪ t ↔ a ∈ s ∨ a ∈ t. This
domain's first plain `Set` packet (every prior packet used `Finset` only, despite
the README focus text explicitly naming "Finset, Set").
Kernel-verified through the tracked proof-search loop (episode d5cb1cff).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem set_mem_union : ∀ {α : Type} (a : α) (s t : Set α), a ∈ s ∪ t ↔ a ∈ s ∨ a ∈ t := by
  intro α a s t
  exact Set.mem_union a s t

end MathCorpus.Elementary.Combinatorics
