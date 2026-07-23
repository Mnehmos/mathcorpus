import Mathlib
/-!
# Closed-form antiderivative of the Mertens main-term kernel

Packet: `number_theory.prime_distribution.harmonic_asymptotics.mertens_main_term_antiderivative.v1`
Level:  L5_grad · Domain: number_theory · Trust rung 1 (Lean kernel).

For every real x ≥ 2, ∫_2^x (log t + 1)/(t log² t) dt = (log log x − 1/log x) − (log log 2 − 1/log 2).
Kernel-verified through the tracked proof-search loop (episode 36f8eaa9).
-/

namespace MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics

theorem mertens_main_term_antiderivative :
    ∀ x : ℝ, 2 ≤ x →
      ∫ t in (2:ℝ)..x, (Real.log t + 1) / (t * (Real.log t)^2)
        = (Real.log (Real.log x) - (Real.log x)⁻¹)
          - (Real.log (Real.log 2) - (Real.log 2)⁻¹) := by
  intro x hx
  have hsubset : Set.Icc (2:ℝ) x ⊆ {t : ℝ | t ≠ 0} := by
    intro t ht
    have h1 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    exact ne_of_gt (by linarith)
  have hmain : ∀ t ∈ Set.uIcc (2:ℝ) x,
      HasDerivAt (fun s => Real.log (Real.log s) - (Real.log s)⁻¹)
        ((Real.log t + 1) / (t * (Real.log t)^2)) t := by
    intro t ht
    rw [Set.uIcc_of_le hx] at ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    have htpos : (0:ℝ) < t := by linarith
    have htne : t ≠ 0 := ne_of_gt htpos
    have hlogtpos : 0 < Real.log t := Real.log_pos (by linarith)
    have hlogtne : Real.log t ≠ 0 := ne_of_gt hlogtpos
    have hlog : HasDerivAt Real.log t⁻¹ t := Real.hasDerivAt_log htne
    have hloglog : HasDerivAt (fun s => Real.log (Real.log s)) ((Real.log t)⁻¹ * t⁻¹) t :=
      (Real.hasDerivAt_log hlogtne).comp t hlog
    have hinv : HasDerivAt (fun s => (Real.log s)⁻¹) (-t⁻¹ / Real.log t ^ 2) t :=
      hlog.inv hlogtne
    have hsub := hloglog.sub hinv
    have hval : (Real.log t)⁻¹ * t⁻¹ - -t⁻¹ / Real.log t ^ 2 = (Real.log t + 1) / (t * (Real.log t)^2) := by
      field_simp
      ring
    rw [hval] at hsub
    exact hsub
  have hcont : ContinuousOn (fun t => (Real.log t + 1) / (t * (Real.log t)^2)) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    apply ContinuousOn.div
    · exact (Real.continuousOn_log.mono hsubset).add continuousOn_const
    · exact continuousOn_id.mul ((Real.continuousOn_log.mono hsubset).pow 2)
    · intro t ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      have htne : t ≠ 0 := ne_of_gt (by linarith)
      have hlogtne : Real.log t ≠ 0 := ne_of_gt (Real.log_pos (by linarith))
      exact mul_ne_zero htne (pow_ne_zero 2 hlogtne)
  have hint : IntervalIntegrable (fun t => (Real.log t + 1) / (t * (Real.log t)^2)) MeasureTheory.volume 2 x :=
    hcont.intervalIntegrable
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hmain hint]


end MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics
