import Mathlib

/-!
# Union-closed sets conjecture: sharpness of the 1/2 constant

Packet: `frontier.formal_conjectures.union_closed_sharpness.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

The union-closed sets conjecture (Frankl's conjecture) asserts a constant
`1/2`: for every finite union-closed family `A` (other than `{∅}`), some
element belongs to at least half the sets in `A`. This packet transports
the companion sharpness result: the constant `1/2` cannot be improved --
for any `c > 1/2`, there is a union-closed family (other than `{∅}`) for
which NO element reaches a `c`-fraction. Witness: `A = Finset.univ` (all
subsets of the ambient type `n`), which is union-closed and not `{∅}`;
every element `i` belongs to exactly half (`2^(|n|-1)` out of `2^|n|`) of
the sets in this `A`, so no element can reach a fraction strictly greater
than `1/2`.

Source: `formal-conjectures/FormalConjectures/Wikipedia/UnionClosed.lean::
union_closed.variants.sharpness` (sibling repo
mnehmos.llm-driven-proof-search.environment), a genuinely proof-complete
(non-`sorry`) upstream theorem -- the third and largest of that file's
three proof-complete special cases (the other two, `singleton_mem` and
`univ_card_two`, are transported separately). Inlines the upstream
file's `IsUnionClosed` abbrev and `#`/set-builder-filter notation (both
`scoped` behind `open Finset`, unavailable to `SubmitModule` items) as
plain conjunction/`Finset.filter` forms; otherwise essentially verbatim.
Kernel-verified through the tracked proof-search loop (episode
`d3e6c1ee-ddc3-49e6-b774-6e63e9f8db8e`) on the first attempt.
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem union_closed_sharpness :
    ∀ {n : Type*} [DecidableEq n] [Fintype n] (c : ℝ), 1 / 2 < c →
      ¬ (∀ A : Finset (Finset n), A ≠ ({∅} : Finset (Finset n)) →
          (∀ X ∈ A, ∀ Y ∈ A, X ∪ Y ∈ A) →
          ∃ i : n, c * (Finset.card A : ℝ) ≤ ((Finset.filter (fun x => i ∈ x) A).card : ℝ)) := by
  intro n _ _ c hc h
  obtain hn | hn := isEmpty_or_nonempty n
  · specialize h ∅
    simp only [ne_eq, Finset.card_empty, CharP.cast_eq_zero, mul_zero, Finset.filter_empty, le_refl,
      IsEmpty.exists_iff, imp_false, not_forall, Finset.notMem_empty, exists_const, Decidable.not_not] at h
    have hmem : ∅ ∈ (∅ : Finset (Finset n)) := by simp [h]
    simp at hmem
  let A : Finset (Finset n) := Finset.univ
  have h_ne_singleton_empty : A ≠ ({∅} : Finset (Finset n)) := by
    have hcard : A.card = 2 ^ Fintype.card n := by simp [A]
    have hlt : 1 < A.card := by simp [hcard]
    intro heq
    simp [heq] at hlt
  obtain ⟨i, hi⟩ := h Finset.univ h_ne_singleton_empty (by intro X _ Y _; exact Finset.mem_univ _)
  have hn2 : 1 ≤ Fintype.card n := by
    rw [Nat.add_one_le_iff]
    exact Fintype.card_pos
  have hcardi : (Finset.univ.filter (fun x => i ∈ x) : Finset (Finset n)).card = 2 ^ (Fintype.card n - 1) := by
    have heqset : (Finset.univ.filter (fun x => i ∈ x) : Finset (Finset n)) = (Finset.univ.erase i).powerset.image (insert i) := by
      ext x
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_image, Finset.mem_powerset,
        Finset.subset_erase, Finset.subset_univ]
      constructor
      · intro h
        use x.erase i
        simp [h]
      · rintro ⟨_, _, rfl⟩
        simp
    rw [heqset, Finset.card_image_of_injOn, Finset.card_powerset]
    · simp
    intro a ha b hb heq
    simp only [Finset.coe_powerset, Finset.coe_erase, Finset.coe_univ, Set.mem_preimage, Set.mem_powerset_iff,
      Set.subset_diff, Set.subset_univ, Set.disjoint_singleton_right, Finset.mem_coe, true_and] at ha hb
    have hh := congr(($heq).erase i)
    rwa [Finset.erase_insert ha, Finset.erase_insert hb] at hh
  simp only [Finset.card_univ, Fintype.card_finset, Nat.cast_pow, Nat.cast_ofNat, hcardi] at hi
  rw [pow_sub₀ _ (by simp) hn2] at hi
  have hcontra1 : (1 / 2 : ℚ) * 2 ^ (Fintype.card n) < c * 2 ^ (Fintype.card n) := by
    gcongr
    simpa using hc
  have hcontra2 : (0 : ℝ) < 0 := by linear_combination hcontra1 + hi
  simp at hcontra2

end MathCorpus.Frontier.FormalConjectures
