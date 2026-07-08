import Mathlib
/-!
# Erdős #349 assembly piece: integer t ≥ 2 fails to be a good coefficient

Packet: `frontier.erdos.erdos_349_int_coeff_ge_two_not_is_good_pair.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Another assembly piece supporting Erdős #349's `integer_isGoodPair_iff`
characterization: for integer `t ≥ 2` and any integer `α`, the pair
`(t, α)` is **not** good. This is infrastructure supporting #349, not a
resolution of the problem itself (which remains genuinely open in
general).

## Proof idea

Pick `k` not divisible by `t` (e.g. `k = t·(|N|+1) + 1` for any threshold
`N`). Then `k` cannot equal any finite subset-sum, since every term
`t·α^n` is a multiple of `t`, so any such sum would be divisible by `t`,
but `k` is not.

Kernel-verified through the tracked proof-search loop (episode
13b04fb7), re-proving (independently in this environment's own pinned
toolchain) the result already Lean-verified in the sibling repo at
`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\erdos-349\proof\Erdos349_int_coeff_ge_two_not_isGoodPair.lean`.
-/

namespace MathCorpus.Frontier.Erdos

theorem erdos_349_int_coeff_ge_two_not_is_good_pair :
    ∀ (t : ℤ), 2 ≤ t → ∀ (α : ℤ),
    ¬ (∀ᶠ k in Filter.atTop, k ∈ {n : ℤ | ∃ B : Finset ℤ,
      ↑B ⊆ Set.range (fun n : ℕ ↦ ⌊(t:ℝ) * (α:ℝ) ^ n⌋) ∧ n = ∑ i ∈ B, i}) := by
  intro t ht α h
  rw [Filter.eventually_atTop] at h
  obtain ⟨N, hN⟩ := h
  set k : ℤ := t * (N.natAbs + 1) + 1 with hkdef
  have hNk : N ≤ k := by
    have h1 : N ≤ (N.natAbs : ℤ) := Int.le_natAbs
    have h2 : (0:ℤ) ≤ N.natAbs := Int.natCast_nonneg N.natAbs
    nlinarith
  have hkt : ¬ (t ∣ k) := by
    rintro ⟨c, hc⟩
    have h1 : t ∣ (1:ℤ) := ⟨c - (N.natAbs + 1), by linarith [hc]⟩
    have := Int.le_of_dvd one_pos h1
    omega
  obtain ⟨B, hBsub, hBeq⟩ := hN k hNk
  apply hkt
  rw [hBeq]
  apply Finset.dvd_sum
  intro i hi
  obtain ⟨n, hn⟩ := hBsub hi
  simp only at hn
  rw [← hn]
  have heq : (t:ℝ) * (α:ℝ)^n = ((t * α^n : ℤ) : ℝ) := by push_cast; ring
  rw [heq, Int.floor_intCast]
  exact ⟨α^n, rfl⟩

end MathCorpus.Frontier.Erdos
