import Mathlib
/-!
# Erdős #349 assembly piece: the pair (1, 2) is good

Packet: `frontier.erdos.erdos_349_one_two_is_good_pair.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

One of `integer_isGoodPair_iff`'s four assembly pieces supporting Erdős
#349's integer-pair characterization: the pair `(1, 2)` is good — every
sufficiently large integer `k` is a finite sum of distinct elements of
`{⌊1 · 2^n⌋ | n : ℕ} = {2^n | n : ℕ}` (the binary representation
existence fact, lifted through `⌊·⌋`). This is infrastructure supporting
#349, not a resolution of the problem itself (which remains genuinely
open in general).

Kernel-verified through the tracked proof-search loop (episode
a6b56b68), re-proving (independently in this environment's own pinned
toolchain) the result already Lean-verified in the sibling repo at
`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\erdos-349\proof\Erdos349_one_two_isGoodPair.lean`.
-/

namespace MathCorpus.Frontier.Erdos

theorem erdos_349_one_two_is_good_pair :
    ∀ᶠ k in Filter.atTop, k ∈ {n : ℤ | ∃ B : Finset ℤ,
      ↑B ⊆ Set.range (fun n : ℕ ↦ ⌊(1:ℝ) * (2:ℝ) ^ n⌋) ∧ n = ∑ i ∈ B, i} := by
  rw [Filter.eventually_atTop]
  refine ⟨0, fun k hk => ?_⟩
  set E := k.toNat.bitIndices.toFinset with hEdef
  have hE : k.toNat = ∑ i ∈ E, 2 ^ i := (Finset.sum_toFinset_bitIndices_two_pow k.toNat).symm
  refine ⟨E.image (fun i => (2:ℤ)^i), ?_, ?_⟩
  · rintro x hx
    simp only [Finset.coe_image, Set.mem_image, Finset.mem_coe] at hx
    obtain ⟨i, _, rfl⟩ := hx
    refine ⟨i, ?_⟩
    show ⌊(1:ℝ) * (2:ℝ)^i⌋ = 2^i
    have hc : (1:ℝ) * (2:ℝ)^i = ((2^i : ℤ) : ℝ) := by push_cast; ring
    rw [hc, Int.floor_intCast]
  · have hinj : Function.Injective (fun i : ℕ => (2:ℤ)^i) := by
      intro a b hab
      simp only at hab
      have : (2:ℕ)^a = (2:ℕ)^b := by exact_mod_cast hab
      exact Nat.pow_right_injective (le_refl 2) this
    rw [Finset.sum_image (fun x _ y _ h => hinj h)]
    have hk' : k = (k.toNat : ℤ) := (Int.toNat_of_nonneg hk).symm
    rw [hk']
    exact_mod_cast hE

end MathCorpus.Frontier.Erdos
