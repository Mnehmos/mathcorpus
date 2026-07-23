import Mathlib
/-!
# Closed-form Mertens weight integral

Packet: `number_theory.prime_distribution.harmonic_asymptotics.mertens_weight_integral_closed_form.v1`
Level:  L5_grad · Domain: number_theory · Trust rung 1 (Lean kernel).

For every real x ≥ 2, ∫_2^x (log t + 1)/(t² log² t) dt = 1/(2 log 2) − 1/(x log x).
Kernel-verified through the tracked proof-search loop (episode 700f297f).
-/

namespace MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics

theorem mertens_weight_integral_closed_form :
    ∀ x : ℝ, 2 ≤ x →
      ∫ t in (2:ℝ)..x, (Real.log t + 1) / (t^2 * (Real.log t)^2)
        = (2 * Real.log 2)⁻¹ - (x * Real.log x)⁻¹ := by
  intro x hx
  have hsubset : Set.Icc (2:ℝ) x ⊆ {t : ℝ | t ≠ 0} := by
    intro t ht
    have h1 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    exact ne_of_gt (by linarith)
  have hmain : ∀ t ∈ Set.uIcc (2:ℝ) x,
      HasDerivAt (fun s => -(s * Real.log s)⁻¹)
        ((Real.log t + 1) / (t^2 * (Real.log t)^2)) t := by
    intro t ht
    rw [Set.uIcc_of_le hx] at ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    have htpos : (0:ℝ) < t := by linarith
    have htne : t ≠ 0 := ne_of_gt htpos
    have hlogtpos : 0 < Real.log t := Real.log_pos (by linarith)
    have hlogtne : Real.log t ≠ 0 := ne_of_gt hlogtpos
    have htl : HasDerivAt (fun s => s * Real.log s) (Real.log t + 1) t := by
      have h1 : HasDerivAt (fun s : ℝ => s * Real.log s) (1 * Real.log t + t * t⁻¹) t :=
        (hasDerivAt_id t).mul (Real.hasDerivAt_log htne)
      have heq : (1:ℝ) * Real.log t + t * t⁻¹ = Real.log t + 1 := by field_simp
      rwa [heq] at h1
    have htlne : t * Real.log t ≠ 0 := mul_ne_zero htne hlogtne
    have hinv : HasDerivAt (fun s => (s * Real.log s)⁻¹) (-(Real.log t + 1) / (t * Real.log t) ^ 2) t := htl.inv htlne
    have hneg := hinv.neg
    have hval : -(-(Real.log t + 1) / (t * Real.log t) ^ 2) = (Real.log t + 1) / (t^2 * (Real.log t)^2) := by
      field_simp
    rw [hval] at hneg
    exact hneg
  have hcont : ContinuousOn (fun t => (Real.log t + 1) / (t^2 * (Real.log t)^2)) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    apply ContinuousOn.div
    · exact (Real.continuousOn_log.mono hsubset).add continuousOn_const
    · exact ((continuousOn_id.pow 2)).mul ((Real.continuousOn_log.mono hsubset).pow 2)
    · intro t ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      have htne : t ≠ 0 := ne_of_gt (by linarith)
      have hlogtne : Real.log t ≠ 0 := ne_of_gt (Real.log_pos (by linarith))
      exact mul_ne_zero (pow_ne_zero 2 htne) (pow_ne_zero 2 hlogtne)
  have hint : IntervalIntegrable (fun t => (Real.log t + 1) / (t^2 * (Real.log t)^2)) MeasureTheory.volume 2 x :=
    hcont.intervalIntegrable
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hmain hint]
  ring


end MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics
