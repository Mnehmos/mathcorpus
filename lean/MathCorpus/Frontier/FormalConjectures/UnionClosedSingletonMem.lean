import Mathlib

/-!
# Union-closed sets conjecture: the "contains a singleton" special case

Packet: `frontier.formal_conjectures.union_closed_singleton_mem.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

The union-closed sets conjecture (Frankl's conjecture): for every finite
union-closed family of sets, other than the family containing only the
empty set, there exists an element belonging to at least half the sets
in the family. This remains open in general (both in this corpus and in
the literature; the best known general bound is Yu's ~0.38234 constant,
not the conjectured 1/2). This packet transports a genuine special case
that IS fully proved: if the union-closed family `A` contains some
singleton `{i}`, then `i` itself witnesses the `≥ 1/2` bound.

Source: `formal-conjectures/FormalConjectures/Wikipedia/UnionClosed.lean::
union_closed.variants.singleton_mem` (sibling repo
mnehmos.llm-driven-proof-search.environment), a genuinely proof-complete
(non-`sorry`) upstream theorem, transported essentially verbatim (only
the upstream file's `IsUnionClosed` abbrev and the `#`/set-builder-filter
notation, both scoped behind `open Finset` which `SubmitModule` items
cannot include, are inlined/spelled out as plain `Finset.card`/
`Finset.filter` applications). Kernel-verified through the tracked
proof-search loop (episode `ff2e3924-a37c-44aa-9c0d-b60e3bf4e81f`) on
the first attempt.
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem union_closed_singleton_mem :
    ∀ {n : Type*} [DecidableEq n] {A : Finset (Finset n)},
      (∀ X ∈ A, ∀ Y ∈ A, X ∪ Y ∈ A) →
      ∀ (i : n), {i} ∈ A →
      ∃ i, (1 / 2 : ℚ) * (Finset.card A) ≤ Finset.card (Finset.filter (fun x => i ∈ x) A) := by
  intro n _ A h_union_closed i hi
  use i
  set B : Finset (Finset n) := Finset.filter (fun x => i ∉ x) A
  set C : Finset (Finset n) := Finset.filter (fun x => i ∈ x) A
  have h₁ : (B : Set (Finset n)).InjOn (insert i) := by
    simp only [Set.InjOn, Finset.coe_filter, Set.mem_setOf_eq, and_imp, B]
    rintro x - hx y - hy hxy
    have := congr(($hxy).erase i)
    rwa [Finset.erase_insert hx, Finset.erase_insert hy] at this
  have h₂ : (B : Set (Finset n)).MapsTo (insert i) C := by
    simp only [Set.MapsTo, Finset.coe_filter, Set.mem_setOf_eq, Finset.mem_insert, true_or, and_true,
      and_imp, B, C]
    intro x hx hix
    rw [Finset.insert_eq]
    exact h_union_closed _ hi _ hx
  have h₃ : Finset.card B ≤ Finset.card C := Finset.card_le_card_of_injOn _ h₂ h₁
  have h₄ : Finset.card C + Finset.card B = Finset.card A := by rw [Finset.card_filter_add_card_filter_not]
  have : Finset.card A ≤ 2 * Finset.card C := by omega
  cancel_denoms
  norm_cast

end MathCorpus.Frontier.FormalConjectures
