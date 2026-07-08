import Mathlib
/-!
# Erdős #494 companion (Steinerberger): the product version is false

Packet: `frontier.erdos.erdos_494_product.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Erdős asked whether a finite `A ⊆ ℂ` is determined by the multiset of
sums of its `k`-element subsets. This file proves the known **companion**
counterexample by Steinerberger: the multiplicative analogue is false —
there exist distinct finite `A, B ⊆ ℂ` of equal cardinality with the same
multiset of 3-subset products. This is a false-generalization companion,
not the (sum-version) Erdős question itself.

## Counterexample

Let `ω` be a primitive cube root of unity, `A = {1, ω, ω², 2}`,
`B = ω·A` (`A ≠ B`). Each 3-subset product scales by `ω³ = 1`, so the
3-subset product multisets of `A` and `B` coincide.

Kernel-verified through the tracked proof-search loop (episode
d4688926), re-proving (independently in this environment's own pinned
toolchain) the result already Lean-verified in the sibling repo at
`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\erdos-494\proof\Erdos494_product.lean`.
-/

namespace MathCorpus.Frontier.Erdos

/-- The multiset of products of `k`-element subsets of `A`. -/
noncomputable def prodMultiset (A : Finset ℂ) (k : ℕ) : Multiset ℂ :=
  (A.powersetCard k).val.map (fun s => s.prod id)

/-- Scaling every element of `A` by `c` with `c ^ k = 1` leaves the
multiset of `k`-subset products unchanged. -/
theorem prodMultiset_map_mul (A : Finset ℂ) (c : ℂ) (k : ℕ) (hc : c ^ k = 1)
    (emb : ℂ ↪ ℂ) (hemb : ⇑emb = (c * ·)) :
    prodMultiset (A.map emb) k = prodMultiset A k := by
  unfold prodMultiset
  rw [Finset.powersetCard_map]
  simp only [Finset.map_val, Multiset.map_map]
  apply Multiset.map_congr rfl
  intro s hs
  have hcard : s.card = k := (Finset.mem_powersetCard.mp (Finset.mem_val.mp hs)).2
  rw [Function.comp_apply, show (Finset.mapEmbedding emb).toEmbedding s = s.map emb from rfl,
    Finset.prod_map]
  simp only [hemb, id_eq]
  rw [Finset.prod_mul_distrib, Finset.prod_const, hcard, hc, one_mul]

/-- **Erdős #494 (product version, false — Steinerberger).** There are
distinct finite `A, B ⊆ ℂ` of equal cardinality with the same multiset of
3-subset products. Companion result only — does not resolve Erdős #494's
sum-version question. -/
theorem erdos_494_product :
    ∃ (A B : Finset ℂ), A.card = B.card ∧ prodMultiset A 3 = prodMultiset B 3 ∧
      A ≠ B := by
  have h3 : (3 : ℕ) ≠ 0 := by norm_num
  have hprim : IsPrimitiveRoot (Complex.exp (2 * ↑Real.pi * Complex.I / 3)) 3 :=
    Complex.isPrimitiveRoot_exp 3 h3
  set ω : ℂ := Complex.exp (2 * ↑Real.pi * Complex.I / 3) with hωdef
  have hω3 : ω ^ 3 = 1 := hprim.pow_eq_one
  have hω0 : ω ≠ 0 := by
    intro h; rw [h] at hω3; simp at hω3
  have hω1 : ω ≠ 1 := by
    intro h; exact hprim.ne_one (by norm_num) h
  let emb : ℂ ↪ ℂ := ⟨(ω * ·), mul_right_injective₀ hω0⟩
  refine ⟨{1, ω, ω ^ 2, 2}, ({1, ω, ω ^ 2, 2} : Finset ℂ).map emb, ?_, ?_, ?_⟩
  · rw [Finset.card_map]
  · exact (prodMultiset_map_mul {1, ω, ω ^ 2, 2} ω 3 hω3 emb rfl).symm
  · intro hAB
    have h2A : (2 : ℂ) ∈ ({1, ω, ω ^ 2, 2} : Finset ℂ) := by simp
    rw [hAB, Finset.mem_map] at h2A
    obtain ⟨x, hxA, hx2⟩ := h2A
    simp only [emb, Function.Embedding.coeFn_mk] at hx2
    simp only [Finset.mem_insert, Finset.mem_singleton] at hxA
    rcases hxA with rfl | rfl | rfl | rfl
    · rw [mul_one] at hx2; rw [hx2] at hω3; norm_num at hω3
    · have : ω ^ 6 = 2 ^ 3 := by rw [show ω ^ 6 = (ω * ω) ^ 3 by ring, hx2]
      rw [show ω ^ 6 = (ω ^ 3) ^ 2 by ring, hω3] at this; norm_num at this
    · rw [show ω * ω ^ 2 = ω ^ 3 by ring, hω3] at hx2; norm_num at hx2
    · apply hω1
      have : ω * 2 = 1 * 2 := by rw [hx2]; ring
      exact mul_right_cancel₀ (by norm_num) this

end MathCorpus.Frontier.Erdos
