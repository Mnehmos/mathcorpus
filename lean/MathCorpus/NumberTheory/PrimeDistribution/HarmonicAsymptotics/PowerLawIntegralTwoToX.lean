import Mathlib
/-!
# Power-law comparison integral

Packet: `number_theory.prime_distribution.harmonic_asymptotics.power_law_integral_two_to_x.v1`
Level:  L4_advanced_undergrad · Domain: number_theory · Trust rung 1 (Lean kernel).

For every real x ≥ 2, ∫_2^x t⁻² dt = 1/2 − 1/x.
Kernel-verified through the tracked proof-search loop (episode 1f97aff1).
-/

namespace MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics

theorem power_law_integral_two_to_x :
    ∀ x : ℝ, 2 ≤ x → ∫ t in (2:ℝ)..x, ((t^2)⁻¹) = (2:ℝ)⁻¹ - x⁻¹ := by
  intro x hx
  have hmain : ∀ t ∈ Set.uIcc (2:ℝ) x, HasDerivAt (fun s => -s⁻¹) ((t^2)⁻¹) t := by
    intro t ht
    rw [Set.uIcc_of_le hx] at ht
    have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
    have htne : t ≠ 0 := ne_of_gt (by linarith)
    have hi : HasDerivAt (fun s : ℝ => s⁻¹) (-(t^2)⁻¹) t := hasDerivAt_inv htne
    have hneg := hi.neg
    have hval : - -(t^2)⁻¹ = (t^2)⁻¹ := by ring
    rw [hval] at hneg
    exact hneg
  have hcont : ContinuousOn (fun t => (t^2)⁻¹) (Set.uIcc (2:ℝ) x) := by
    rw [Set.uIcc_of_le hx]
    apply ContinuousOn.inv₀
    · exact continuousOn_id.pow 2
    · intro t ht
      have ht2 : (2:ℝ) ≤ t := (Set.mem_Icc.mp ht).1
      exact pow_ne_zero 2 (ne_of_gt (by linarith))
  have hint : IntervalIntegrable (fun t => (t^2)⁻¹) MeasureTheory.volume 2 x := hcont.intervalIntegrable
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hmain hint]
  ring


end MathCorpus.NumberTheory.PrimeDistribution.HarmonicAsymptotics
