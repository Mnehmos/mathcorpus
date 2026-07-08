import Mathlib

/-!
# General n-term (unweighted) AM-GM inequality

Packet: `elementary.inequalities.general_amgm.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For a nonempty finite index set s and nonnegative reals z i, the
geometric mean (product raised to 1/|s|) is at most the arithmetic mean
(sum divided by |s|). Derived from Mathlib's
`Real.geom_mean_le_arith_mean_weighted` (the weighted AM-GM for Finsets)
by setting all weights to the constant `1/|s|` -- closing the "general
n-term AM-GM" backlog item in `packets/elementary/inequalities/QUEUE.md`,
previously assumed to need new `InequalityEstimateKit` infrastructure,
but directly derivable from an existing Mathlib lemma instead.
Kernel-verified through the tracked proof-search loop (episode 71fafcd9).
-/

namespace MathCorpus.Elementary.Inequalities

theorem general_amgm {ι : Type*} (s : Finset ι) (z : ι → ℝ) (hs : s.Nonempty)
    (hz : ∀ i ∈ s, 0 ≤ z i) :
    (∏ i ∈ s, z i) ^ ((s.card : ℝ))⁻¹ ≤ (∑ i ∈ s, z i) / s.card := by
  have hcardpos : 0 < s.card := Finset.card_pos.mpr hs
  have hcard0 : (s.card : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hcardpos.ne'
  have hw : ∀ i ∈ s, (0 : ℝ) ≤ (s.card : ℝ)⁻¹ := fun i _ => inv_nonneg.mpr (Nat.cast_nonneg s.card)
  have hw' : ∑ _i ∈ s, (s.card : ℝ)⁻¹ = 1 := by
    rw [Finset.sum_const, nsmul_eq_mul]
    exact mul_inv_cancel₀ hcard0
  have hmain := Real.geom_mean_le_arith_mean_weighted s (fun _ => (s.card : ℝ)⁻¹) z hw hw' hz
  rw [Real.finsetProd_rpow s z hz, ← Finset.mul_sum] at hmain
  rw [div_eq_inv_mul]
  exact hmain

end MathCorpus.Elementary.Inequalities
