import Mathlib
import MathCorpus.NumberTheory.PrimeDistribution.Mertens.MertensExactThetaIdentity
import MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics.MertensMainTermAntiderivative
import MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics.MertensWeightIntegralClosedForm
import MathCorpus.NumberTheory.PrimeDistribution.ExplicitBounds.MertensErrorIntegralLogBound
import MathCorpus.NumberTheory.PrimeDistribution.ExplicitBounds.MertensErrorIntegralSqrtBound
import MathCorpus.NumberTheory.PrimeDistribution.ChebyshevTheta.ThetaRealLowerBridge
/-!
# Quantitative Mertens lower bound for the prime reciprocal sum

Packet: `number_theory.prime_distribution.prime_reciprocal_sums.prime_reciprocal_quantitative_lower.v1`
Level:  L6_known_theorem · Domain: number_theory · Trust rung 1 (Lean kernel).

For every real x ≥ 2, log 2 · log log x − (1/2 + log 2 · log log 2 + (1 + 1/log 2)(1 + 2√2)) ≤ ∑_{p≤x} 1/p: an unconditional, fully explicit quantitative form of Mertens' second theorem (with leading constant log 2 in place of the optimal 1).
Kernel-verified through the tracked proof-search loop (episode 2e9066f2).
-/

namespace MathCorpus.NumberTheory.PrimeDistribution.PrimeReciprocalSums

theorem prime_reciprocal_quantitative_lower :
    ∀ x : ℝ, 2 ≤ x → Real.log 2 * Real.log (Real.log x) -
      (1/2 + Real.log 2 * Real.log (Real.log 2) + (1 + (Real.log 2)⁻¹) * (1 + 2*Real.sqrt 2))
      ≤ ∑ p ∈ Finset.Icc 1 ⌊x⌋₊ with p.Prime, (1/(p:ℝ)) := by
  intro x hx
  have hlogxpos : 0 < Real.log x := Real.log_pos (by linarith)
  have hxpos : 0 < x := by linarith
  have hlog2pos : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hsubset2 : Set.Icc (2:ℝ) x ⊆ {t:ℝ | t ≠ 0} := by
    intro t ht
    have h1 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    exact ne_of_gt (by linarith)
  have hid : ∑ p ∈ Finset.Icc 1 ⌊x⌋₊ with p.Prime, (1/(p:ℝ))
      = Chebyshev.theta x / (x * Real.log x)
        + ∫ t in Set.Ioc (2:ℝ) x,
            (Real.log t + 1) / (t^2 * (Real.log t)^2) * Chebyshev.theta t :=
    Mertens.mertens_exact_theta_identity x hx
  have hMain : ∫ t in (2:ℝ)..x, (Real.log t + 1) / (t * (Real.log t)^2)
      = (Real.log (Real.log x) - (Real.log x)⁻¹) - (Real.log (Real.log 2) - (Real.log 2)⁻¹) :=
    HarmonicAsymptotics.mertens_main_term_antiderivative x hx
  have hWeight : ∫ t in (2:ℝ)..x, (Real.log t + 1) / (t^2 * (Real.log t)^2)
      = (2 * Real.log 2)⁻¹ - (x * Real.log x)⁻¹ :=
    HarmonicAsymptotics.mertens_weight_integral_closed_form x hx
  have hE2 : (∫ t in (2:ℝ)..x, (Real.log t + 1) * Real.log (t + 2) / (t^2 * (Real.log t)^2))
      ≤ 1 + (Real.log 2)⁻¹ :=
    ExplicitBounds.mertens_error_integral_log_bound x hx
  have hE3 : (∫ t in (2:ℝ)..x, (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2))
      ≤ 2 * Real.sqrt 2 * (1 + (Real.log 2)⁻¹) :=
    ExplicitBounds.mertens_error_integral_sqrt_bound x hx
  have hLge : ∀ t : ℝ, 2 ≤ t → (t - 1) * Real.log 2 - Real.log (t + 2) - 2 * Real.sqrt t * Real.log t ≤ Chebyshev.theta t :=
    ChebyshevTheta.theta_real_lower_bridge
  have hthetaxnn : 0 ≤ Chebyshev.theta x := Chebyshev.theta_nonneg x
  have hbd0 : 0 ≤ Chebyshev.theta x / (x * Real.log x) := div_nonneg hthetaxnn (le_of_lt (mul_pos hxpos hlogxpos))
  have hthetamono : Monotone Chebyshev.theta := Chebyshev.theta_mono
  have hthetaIntv : IntervalIntegrable Chebyshev.theta MeasureTheory.volume 2 x := hthetamono.intervalIntegrable
  have hwcont : ContinuousOn (fun t => (Real.log t + 1) / (t^2 * (Real.log t)^2)) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    apply ContinuousOn.div
    · exact (Real.continuousOn_log.mono hsubset2).add continuousOn_const
    · exact (continuousOn_pow 2).mul ((Real.continuousOn_log.mono hsubset2).pow 2)
    · intro t ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      have htpos : (0:ℝ) < t := by linarith
      have hlogtpos : 0 < Real.log t := Real.log_pos (by linarith)
      positivity
  have hthetawInt : IntervalIntegrable (fun t => Chebyshev.theta t * ((Real.log t + 1) / (t^2 * (Real.log t)^2))) MeasureTheory.volume 2 x := hthetaIntv.mul_continuousOn hwcont
  have hIocEq : (∫ t in Set.Ioc (2:ℝ) x, (Real.log t + 1) / (t^2 * (Real.log t)^2) * Chebyshev.theta t)
      = ∫ t in (2:ℝ)..x, Chebyshev.theta t * ((Real.log t + 1) / (t^2 * (Real.log t)^2)) := by
    rw [intervalIntegral.integral_of_le hx]
    apply MeasureTheory.setIntegral_congr_fun measurableSet_Ioc
    intro t _
    ring
  rw [hIocEq] at hid
  have hLcont : ContinuousOn (fun t : ℝ => (t-1)*Real.log 2 - Real.log (t+2) - 2*Real.sqrt t*Real.log t) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    apply ContinuousOn.sub
    apply ContinuousOn.sub
    · exact (continuousOn_id.sub continuousOn_const).mul continuousOn_const
    · exact Real.continuousOn_log.comp (continuousOn_id.add continuousOn_const) (fun t ht => ne_of_gt (by have := (Set.mem_Icc.mp ht).1; linarith))
    · exact (continuousOn_const.mul (Real.continuous_sqrt.continuousOn)).mul (Real.continuousOn_log.mono hsubset2)
  have hwL_int : IntervalIntegrable (fun t => ((t-1)*Real.log 2 - Real.log (t+2) - 2*Real.sqrt t*Real.log t) * ((Real.log t + 1) / (t^2 * (Real.log t)^2))) MeasureTheory.volume 2 x :=
    hLcont.intervalIntegrable.mul_continuousOn hwcont
  have hptwise_theta_ge_L : ∀ t ∈ Set.Icc (2:ℝ) x, ((t-1)*Real.log 2 - Real.log (t+2) - 2*Real.sqrt t*Real.log t) * ((Real.log t + 1) / (t^2 * (Real.log t)^2)) ≤ Chebyshev.theta t * ((Real.log t + 1) / (t^2 * (Real.log t)^2)) := by
    intro t ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    have hwnn : 0 ≤ (Real.log t + 1) / (t^2 * (Real.log t)^2) := by
      have htpos : (0:ℝ) < t := by linarith
      have hlogtpos : 0 < Real.log t := Real.log_pos (by linarith)
      positivity
    exact mul_le_mul_of_nonneg_right (hLge t ht2) hwnn
  have hmono2 := intervalIntegral.integral_mono_on hx hwL_int hthetawInt hptwise_theta_ge_L
  have hv_cont : ContinuousOn (fun t => (Real.log t + 1) / (t * (Real.log t)^2)) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    apply ContinuousOn.div
    · exact (Real.continuousOn_log.mono hsubset2).add continuousOn_const
    · exact continuousOn_id.mul ((Real.continuousOn_log.mono hsubset2).pow 2)
    · intro t ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      have htne : t ≠ 0 := ne_of_gt (by linarith)
      have hlogtne : Real.log t ≠ 0 := ne_of_gt (Real.log_pos (by linarith))
      exact mul_ne_zero htne (pow_ne_zero 2 hlogtne)
  have hv_int : IntervalIntegrable (fun t => (Real.log t + 1) / (t * (Real.log t)^2)) MeasureTheory.volume 2 x := hv_cont.intervalIntegrable
  have hw_int : IntervalIntegrable (fun t => (Real.log t + 1) / (t^2 * (Real.log t)^2)) MeasureTheory.volume 2 x := hwcont.intervalIntegrable
  have he2_cont : ContinuousOn (fun t => (Real.log t + 1) * Real.log (t + 2) / (t^2 * (Real.log t)^2)) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    have hcontlogt : ContinuousOn (fun t => Real.log t) (Set.Icc (2:ℝ) x) := Real.continuousOn_log.mono hsubset2
    have hcontlogt2 : ContinuousOn (fun t => Real.log (t + 2)) (Set.Icc (2:ℝ) x) :=
      Real.continuousOn_log.comp ((continuous_add_right 2).continuousOn) (fun t ht => ne_of_gt (by have := (Set.mem_Icc.mp ht).1; linarith))
    have hdenne : ∀ t ∈ Set.Icc (2:ℝ) x, t^2 * (Real.log t)^2 ≠ 0 := by
      intro t ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      exact mul_ne_zero (pow_ne_zero 2 (ne_of_gt (by linarith))) (pow_ne_zero 2 (ne_of_gt (Real.log_pos (by linarith))))
    exact ((hcontlogt.add continuousOn_const).mul hcontlogt2).div (((continuous_pow 2).continuousOn).mul (hcontlogt.pow 2)) hdenne
  have he2_int : IntervalIntegrable (fun t => (Real.log t + 1) * Real.log (t + 2) / (t^2 * (Real.log t)^2)) MeasureTheory.volume 2 x := he2_cont.intervalIntegrable
  have he3_cont : ContinuousOn (fun t => (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2)) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    have hcontlogt : ContinuousOn (fun t => Real.log t) (Set.Icc (2:ℝ) x) := Real.continuousOn_log.mono hsubset2
    have hcontsqrt : ContinuousOn (fun t => Real.sqrt t) (Set.Icc (2:ℝ) x) := Real.continuous_sqrt.continuousOn
    have hdenne : ∀ t ∈ Set.Icc (2:ℝ) x, t^2 * (Real.log t)^2 ≠ 0 := by
      intro t ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      exact mul_ne_zero (pow_ne_zero 2 (ne_of_gt (by linarith))) (pow_ne_zero 2 (ne_of_gt (Real.log_pos (by linarith))))
    exact (((hcontlogt.add continuousOn_const).mul ((continuousOn_const.mul hcontsqrt).mul hcontlogt))).div (((continuous_pow 2).continuousOn).mul (hcontlogt.pow 2)) hdenne
  have he3_int : IntervalIntegrable (fun t => (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2)) MeasureTheory.volume 2 x := he3_cont.intervalIntegrable
  have hcongr : (∫ t in (2:ℝ)..x, ((t-1)*Real.log 2 - Real.log (t+2) - 2*Real.sqrt t*Real.log t) * ((Real.log t + 1) / (t^2 * (Real.log t)^2)))
      = ∫ t in (2:ℝ)..x, (Real.log 2 * ((Real.log t + 1) / (t * (Real.log t)^2)) - Real.log 2 * ((Real.log t + 1) / (t^2 * (Real.log t)^2)) - (Real.log t + 1) * Real.log (t+2) / (t^2 * (Real.log t)^2) - (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2)) := by
    apply intervalIntegral.integral_congr
    rw [Set.uIcc_of_le hx]
    intro t ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    have htpos : (0:ℝ) < t := by linarith
    have hlogtpos : 0 < Real.log t := Real.log_pos (by linarith)
    have htne : t ≠ 0 := ne_of_gt htpos
    have hlogtne : Real.log t ≠ 0 := ne_of_gt hlogtpos
    field_simp <;> ring
  have hAB : ∫ t in (2:ℝ)..x, (Real.log 2 * ((Real.log t + 1) / (t * (Real.log t)^2)) - Real.log 2 * ((Real.log t + 1) / (t^2 * (Real.log t)^2)))
      = Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t * (Real.log t)^2)) - Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t^2 * (Real.log t)^2)) := by
    rw [intervalIntegral.integral_sub (hv_int.const_mul _) (hw_int.const_mul _), intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul]
  have hABC : ∫ t in (2:ℝ)..x, (Real.log 2 * ((Real.log t + 1) / (t * (Real.log t)^2)) - Real.log 2 * ((Real.log t + 1) / (t^2 * (Real.log t)^2)) - (Real.log t + 1) * Real.log (t+2) / (t^2 * (Real.log t)^2))
      = (Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t * (Real.log t)^2)) - Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t^2 * (Real.log t)^2))) - (∫ t in (2:ℝ)..x, (Real.log t + 1) * Real.log (t+2) / (t^2 * (Real.log t)^2)) := by
    rw [intervalIntegral.integral_sub ((hv_int.const_mul _).sub (hw_int.const_mul _)) he2_int, hAB]
  have hABCD : ∫ t in (2:ℝ)..x, (Real.log 2 * ((Real.log t + 1) / (t * (Real.log t)^2)) - Real.log 2 * ((Real.log t + 1) / (t^2 * (Real.log t)^2)) - (Real.log t + 1) * Real.log (t+2) / (t^2 * (Real.log t)^2) - (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2))
      = (((Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t * (Real.log t)^2)) - Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t^2 * (Real.log t)^2))) - (∫ t in (2:ℝ)..x, (Real.log t + 1) * Real.log (t+2) / (t^2 * (Real.log t)^2))) - (∫ t in (2:ℝ)..x, (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2))) := by
    rw [intervalIntegral.integral_sub (((hv_int.const_mul _).sub (hw_int.const_mul _)).sub he2_int) he3_int, hABC]
  have hsplit_eq : (∫ t in (2:ℝ)..x, ((t-1)*Real.log 2 - Real.log (t+2) - 2*Real.sqrt t*Real.log t) * ((Real.log t + 1) / (t^2 * (Real.log t)^2)))
      = Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t * (Real.log t)^2))
        - Real.log 2 * (∫ t in (2:ℝ)..x, (Real.log t + 1) / (t^2 * (Real.log t)^2))
        - (∫ t in (2:ℝ)..x, (Real.log t + 1) * Real.log (t+2) / (t^2 * (Real.log t)^2))
        - (∫ t in (2:ℝ)..x, (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2)) := by
    rw [hcongr, hABCD]
  rw [hMain, hWeight] at hsplit_eq
  rw [hsplit_eq] at hmono2
  have hlogxineq : Real.log 2 / Real.log x ≤ 1 := by
    rw [div_le_one hlogxpos]
    exact Real.log_le_log (by norm_num) hx
  have hxlogxnn : 0 ≤ Real.log 2 / (x * Real.log x) := by positivity
  have heq1 : Real.log 2 * (2 * Real.log 2)⁻¹ = 1/2 := by field_simp <;> ring
  have heq2 : Real.log 2 * (Real.log x)⁻¹ = Real.log 2 / Real.log x := by ring
  have heq3 : Real.log 2 * (x * Real.log x)⁻¹ = Real.log 2 / (x * Real.log x) := by ring
  have heq4 : Real.log 2 * (Real.log 2)⁻¹ = 1 := mul_inv_cancel₀ (ne_of_gt hlog2pos)
  linarith [hid, hbd0, hmono2, hE2, hE3, hlogxineq, hxlogxnn, heq1, heq2, heq3, heq4]


end MathCorpus.NumberTheory.PrimeDistribution.PrimeReciprocalSums
