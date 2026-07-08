import Mathlib
/-!
# Erdős #349 assembly piece: α ≤ 1 fails to be a good pair

Packet: `frontier.erdos.erdos_349_alpha_le_one_not_is_good_pair.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

One of `integer_isGoodPair_iff`'s four assembly pieces supporting Erdős
#349's integer-pair characterization: if `α ≤ 1` (with `t, α > 0`), the
pair `(t, α)` is **not** good — it is false that eventually every
integer `k` is a finite sum of distinct elements of
`{⌊t·α^n⌋ | n : ℕ}`. This is infrastructure supporting #349, not a
resolution of the problem itself (which remains genuinely open in
general).

## Proof idea

Since `α ≤ 1`, every term `t·α^n` is bounded within `[0, t]`, so the
whole range `⌊t·α^n⌋` is bounded within `[0, ⌊t⌋]`. Any finite subset sum
is then bounded above by a fixed constant `C = ∑_{i=0}^{⌊t⌋} i`, but
"eventually true" would require arbitrarily large `k` (in particular
`k > C`) to be representable — contradiction.

Kernel-verified through the tracked proof-search loop (episode
5a12b3e9), re-proving (independently in this environment's own pinned
toolchain) the result already Lean-verified in the sibling repo at
`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\erdos-349\proof\Erdos349_alpha_le_one_not_isGoodPair.lean`.
-/

namespace MathCorpus.Frontier.Erdos

theorem erdos_349_alpha_le_one_not_is_good_pair :
    ∀ (t : ℝ), 0 < t → ∀ (α : ℝ), 0 < α → α ≤ 1 →
    ¬ (∀ᶠ k in Filter.atTop, k ∈ {n : ℤ | ∃ B : Finset ℤ,
      ↑B ⊆ Set.range (fun n : ℕ ↦ ⌊t * α ^ n⌋) ∧ n = ∑ i ∈ B, i}) := by
  intro t ht α hα0 hα1 h
  rw [Filter.eventually_atTop] at h
  obtain ⟨N, hN⟩ := h
  have hrange : Set.range (fun n : ℕ ↦ ⌊t * α ^ n⌋) ⊆ ↑(Finset.Icc (0:ℤ) ⌊t⌋) := by
    rintro _ ⟨n, rfl⟩
    simp only [Finset.coe_Icc, Set.mem_Icc]
    have hpow_pos : 0 < α ^ n := pow_pos hα0 n
    have hpow_le : α ^ n ≤ 1 := pow_le_one₀ hα0.le hα1
    have hle : t * α ^ n ≤ t := by nlinarith
    have hpos : 0 < t * α ^ n := by positivity
    exact ⟨Int.floor_nonneg.mpr hpos.le, Int.floor_le_floor hle⟩
  set C : ℤ := ∑ i ∈ Finset.Icc (0:ℤ) ⌊t⌋, i with hCdef
  have hbound : ∀ k ∈ {n : ℤ | ∃ B : Finset ℤ,
      ↑B ⊆ Set.range (fun n : ℕ ↦ ⌊t * α ^ n⌋) ∧ n = ∑ i ∈ B, i}, k ≤ C := by
    rintro k ⟨B, hBsub, rfl⟩
    have hBsub' : B ⊆ Finset.Icc (0:ℤ) ⌊t⌋ := by
      intro x hx
      have hxr := hBsub hx
      have := hrange hxr
      simpa using this
    exact Finset.sum_le_sum_of_subset_of_nonneg hBsub'
      (fun i hi _ => by simpa using (Finset.mem_Icc.mp hi).1)
  have hk := hN (max N (C+1)) (le_max_left _ _)
  have := hbound _ hk
  have hge : C + 1 ≤ max N (C+1) := le_max_right _ _
  omega

end MathCorpus.Frontier.Erdos
