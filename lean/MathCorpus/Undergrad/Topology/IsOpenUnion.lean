import Mathlib

/-!
# Union of two open sets is open

Packet: `undergrad.topology.is_open_union.v1`
Level:  L3_undergrad · Domain: topology · Trust rung 1 (Lean kernel).

The union of two open sets in a topological space is open.
-/

namespace MathCorpus.Undergrad.Topology

theorem is_open_union' {α : Type*} [TopologicalSpace α] {s t : Set α}
    (hs : IsOpen s) (ht : IsOpen t) : IsOpen (s ∪ t) := by
  exact hs.union ht

end MathCorpus.Undergrad.Topology
