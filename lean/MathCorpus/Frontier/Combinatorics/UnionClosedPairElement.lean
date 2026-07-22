import Mathlib

/-!
# Non-empty set in a union-closed pair contains an element of the union

Packet: `frontier.union_closed_pair_element.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

For any non-empty finset A and finset B, the union A ∪ B contains an element.
-/

namespace MathCorpus.Frontier.Combinatorics

theorem union_closed_pair_element' : ∀ {α : Type*} [DecidableEq α] (A B : Finset α), A.Nonempty → ∃ x, x ∈ A ∪ B := by
  intro α inst A B hA
  obtain ⟨x, hx⟩ := hA
  use x
  exact Finset.mem_union_left B hx

end MathCorpus.Frontier.Combinatorics
