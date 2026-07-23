import Mathlib
/-!
# Explicit bound for the square-root Mertens error integral

Packet: `number_theory.prime_distribution.explicit_bounds.mertens_error_integral_sqrt_bound.v1`
Level:  L5_grad · Domain: number_theory · Trust rung 1 (Lean kernel).

For every real x ≥ 2, ∫_2^x (log t + 1) · 2√t · log t/(t² log² t) dt ≤ 2√2 · (1 + 1/log 2).
Kernel-verified through the tracked proof-search loop (episode 44cf70ff).
-/

namespace MathCorpus.NumberTheory.PrimeDistribution.ExplicitBounds

theorem mertens_error_integral_sqrt_bound :
    ∀ x : ℝ, 2 ≤ x →
      (∫ t in (2:ℝ)..x, (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2))
        ≤ 2 * Real.sqrt 2 * (1 + (Real.log 2)⁻¹) := by
  intro x hx
  have hlog2pos : 0 < Real.log 2 := Real.log_pos (by norm_num)
  set C : ℝ := 2 * (1 + (Real.log 2)⁻¹) with hC
  have hCpos : 0 ≤ C := by rw [hC]; positivity
  have hptwise : ∀ t ∈ Set.Icc (2:ℝ) x,
      (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2) ≤ C * (Real.sqrt t / t^2) := by
    intro t ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    have htpos : (0:ℝ) < t := by linarith
    have hlogtpos : 0 < Real.log t := Real.log_pos (by linarith)
    have hsqrtpos : 0 < Real.sqrt t := Real.sqrt_pos.mpr htpos
    have hlog2t : Real.log 2 ≤ Real.log t := Real.log_le_log (by norm_num) ht2
    have hLinv : 1 ≤ (Real.log 2)⁻¹ * Real.log t := by
      have h := mul_le_mul_of_nonneg_left hlog2t (le_of_lt (inv_pos.mpr hlog2pos))
      rwa [inv_mul_cancel₀ (ne_of_gt hlog2pos)] at h
    have hkey : 2 * (Real.log t + 1) ≤ C * Real.log t := by rw [hC]; nlinarith [hLinv]
    rw [div_le_iff₀ (by positivity)]
    have hsimp : C * (Real.sqrt t / t^2) * (t^2 * (Real.log t)^2) = C * Real.sqrt t * (Real.log t)^2 := by
      field_simp
    rw [hsimp]
    have hstep : (2 * (Real.log t + 1)) * (Real.sqrt t * Real.log t) ≤ (C * Real.log t) * (Real.sqrt t * Real.log t) :=
      mul_le_mul_of_nonneg_right hkey (le_of_lt (mul_pos hsqrtpos hlogtpos))
    nlinarith [hstep]
  have hcontlogt : ContinuousOn (fun t => Real.log t) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    exact Real.continuousOn_log.mono (fun t ht => ne_of_gt (by have := (Set.mem_Icc.mp ht).1; linarith))
  have hcontsqrt : ContinuousOn (fun t => Real.sqrt t) (Set.uIcc (2:ℝ) x) := Real.continuous_sqrt.continuousOn
  have hdenne : ∀ t ∈ Set.uIcc (2:ℝ) x, t^2 * (Real.log t)^2 ≠ 0 := by
    rw [Set.uIcc_of_le hx]
    intro t ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    exact mul_ne_zero (pow_ne_zero 2 (ne_of_gt (by linarith))) (pow_ne_zero 2 (ne_of_gt (Real.log_pos (by linarith))))
  have hdenne2 : ∀ t ∈ Set.uIcc (2:ℝ) x, t^2 ≠ 0 := by
    rw [Set.uIcc_of_le hx]
    intro t ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    exact pow_ne_zero 2 (ne_of_gt (by linarith))
  have hcontLHS : ContinuousOn (fun t => (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2)) (Set.uIcc (2:ℝ) x) :=
    (((hcontlogt.add continuousOn_const).mul ((continuousOn_const.mul hcontsqrt).mul hcontlogt))).div (((continuous_pow 2).continuousOn).mul (hcontlogt.pow 2)) hdenne
  have hcontRHS : ContinuousOn (fun t => C * (Real.sqrt t / t^2)) (Set.uIcc (2:ℝ) x) :=
    continuousOn_const.mul (hcontsqrt.div ((continuous_pow 2).continuousOn) hdenne2)
  have hintLHS : IntervalIntegrable (fun t => (Real.log t + 1) * (2 * Real.sqrt t * Real.log t) / (t^2 * (Real.log t)^2)) MeasureTheory.volume 2 x := hcontLHS.intervalIntegrable
  have hintRHS : IntervalIntegrable (fun t => C * (Real.sqrt t / t^2)) MeasureTheory.volume 2 x := hcontRHS.intervalIntegrable
  have hmono := intervalIntegral.integral_mono_on hx hintLHS hintRHS hptwise
  have hpow : ∫ t in (2:ℝ)..x, (Real.sqrt t / t^2) = 2/Real.sqrt 2 - 2/Real.sqrt x := by
    have hmain2 : ∀ t ∈ Set.uIcc (2:ℝ) x, HasDerivAt (fun s => -2 * (Real.sqrt s)⁻¹) (Real.sqrt t / t^2) t := by
      intro t ht
      rw [Set.uIcc_of_le hx] at ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      have htpos : (0:ℝ) < t := by linarith
      have htne : t ≠ 0 := ne_of_gt htpos
      have hsqrtpos : 0 < Real.sqrt t := Real.sqrt_pos.mpr htpos
      have hsqrtne : Real.sqrt t ≠ 0 := ne_of_gt hsqrtpos
      have hs := Real.hasDerivAt_sqrt htne
      have hinv := hs.inv hsqrtne
      have hscaled := hinv.const_mul (-2 : ℝ)
      have hsq : (Real.sqrt t)^2 = t := Real.sq_sqrt (le_of_lt htpos)
      have hnum : ∀ s : ℝ, 0 < s → -2 * (-(1/(2*s))/s^2) = s / (s^2)^2 := by
        intro s hs2
        have hsne : s ≠ 0 := ne_of_gt hs2
        field_simp <;> ring
      have hval := hnum (Real.sqrt t) hsqrtpos
      conv_rhs at hval => rw [hsq]
      convert hscaled using 1 <;> first | rfl | (funext s; rfl) | exact hval.symm
    have hcpow : ContinuousOn (fun t => Real.sqrt t / t^2) (Set.uIcc (2:ℝ) x) :=
      hcontsqrt.div ((continuous_pow 2).continuousOn) hdenne2
    rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hmain2 hcpow.intervalIntegrable]
    ring
  rw [intervalIntegral.integral_const_mul, hpow] at hmono
  have hsq2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hxsqrtpos : 0 < Real.sqrt x := Real.sqrt_pos.mpr (by linarith)
  have h2sqrtpos : 0 < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  have hfinal : C * (2 / Real.sqrt 2 - 2 / Real.sqrt x) ≤ 2 * Real.sqrt 2 * (1 + (Real.log 2)⁻¹) := by
    have hterm : 2 / Real.sqrt 2 = Real.sqrt 2 := by
      rw [eq_comm, eq_div_iff (ne_of_gt h2sqrtpos)]; nlinarith [hsq2]
    have hnn : 0 ≤ C * (2 / Real.sqrt x) := by positivity
    rw [hC] at hCpos ⊢
    nlinarith [hterm, hnn]
  linarith [hmono, hfinal]


end MathCorpus.NumberTheory.PrimeDistribution.ExplicitBounds
