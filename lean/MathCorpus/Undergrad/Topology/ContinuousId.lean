import Mathlib

/-!
# Identity map on any topological space is continuous

Packet: `topology.continuous_id.v1`
Level:  L3_undergrad · Domain: topology · Trust rung 1 (Lean kernel).

The identity map on any topological space is continuous.
-/

namespace MathCorpus.Undergrad.Topology

theorem continuous_id' : ∀ {α : Type*} [TopologicalSpace α], Continuous (id : α → α) := by
  intro α inst
  exact continuous_id

end MathCorpus.Undergrad.Topology
