import Mathlib

/-!
# Intersection of two closed sets is closed

Packet: `undergrad.topology.is_closed_inter.v1`
Level:  L3_undergrad · Domain: topology · Trust rung 1 (Lean kernel).

The intersection of two closed sets in a topological space is closed.
-/

namespace MathCorpus.Undergrad.Topology

theorem is_closed_inter' {α : Type*} [TopologicalSpace α] {s t : Set α}
    (hs : IsClosed s) (ht : IsClosed t) : IsClosed (s ∩ t) := by
  exact hs.inter ht

end MathCorpus.Undergrad.Topology
