import Mathlib
/-!
# Finset union cardinality is not unconditionally additive

Packet: `elementary.combinatorics.card_union_not_additive.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

`(s ∪ t).card = s.card + t.card` is false without a `Disjoint s t` hypothesis
(the correct statement is `Finset.card_union_of_disjoint`). Witnessed here by
`s = t = {0}`. Kernel-verified through the tracked proof-search loop
(episode f2bb04ed). Paired negative example:
`negative.combinatorics.card_union_no_disjoint.false_generalization.v1`
(the natural first attempt to prove the unconditional claim directly).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem not_forall_card_union_eq_add_card :
    ¬ (∀ s t : Finset ℕ, (s ∪ t).card = s.card + t.card) := by
  intro h
  have h0 := h {0} {0}
  simp at h0

end MathCorpus.Elementary.Combinatorics
