import Mathlib

/-!
# Non-empty finset has an element in any union

Packet: `elementary.logic.union_pair_element.v1`
Level:  L1_proof_basics · Domain: logic · Trust rung 1 (Lean kernel).

For any non-empty finset A and finset B, the union A ∪ B contains an element.
-/

namespace MathCorpus.Elementary.Logic

theorem union_pair_element : ∀ {α : Type*} [DecidableEq α] (A B : Finset α), A.Nonempty → ∃ x, x ∈ A ∪ B := by
  intro α inst A B hA
  obtain ⟨x, hx⟩ := hA
  use x
  exact Finset.mem_union_left B hx

end MathCorpus.Elementary.Logic
