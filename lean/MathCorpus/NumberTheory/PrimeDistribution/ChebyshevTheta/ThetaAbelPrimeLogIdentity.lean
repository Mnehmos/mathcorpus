import Mathlib
/-!
# Abel identity for the prime logarithmic moment

Packet: `number_theory.prime_distribution.chebyshev_theta.theta_abel_prime_log_identity.v1`
Level:  L5_grad · Domain: number_theory · Trust rung 1 (Lean kernel).

For every real x ≥ 2, ∑_{p≤x} log p / p = θ(x)/x + ∫_{(2,x]} θ(t)/t² dt.
Kernel-verified through the tracked proof-search loop (episode fbf2047c).
-/

namespace MathCorpus.NumberTheory.PrimeDistribution.ChebyshevTheta

theorem theta_abel_prime_log_identity :
    ∀ x : ℝ, 2 ≤ x →
      ∑ p ∈ Finset.Icc 1 ⌊x⌋₊ with p.Prime, Real.log p / (p:ℝ)
        = Chebyshev.theta x / x +
          ∫ t in Set.Ioc (2:ℝ) x, Chebyshev.theta t / t^2 := by
  intro x hx
  set f : ℝ → ℝ := fun t => t⁻¹ with hf_def
  set g : ℝ → ℝ := fun t => -(t^2)⁻¹ with hg_def
  set c : ℕ → ℝ := fun k => if k.Prime then Real.log k else 0 with hc_def
  have hsub : Set.Icc (2:ℝ) x ⊆ {t:ℝ | t ≠ 0} := by
    intro t ht
    exact ne_of_gt (by linarith [(Set.mem_Icc.mp ht).1])
  have hderiv : ∀ t ∈ Set.Icc (2:ℝ) x, HasDerivAt f (g t) t := by
    intro t ht
    have htne : t ≠ 0 := hsub ht
    rw [hf_def, hg_def]
    exact hasDerivAt_inv htne
  have hf_diff : ∀ t ∈ Set.Icc (2:ℝ) x, DifferentiableAt ℝ f t :=
    fun t ht => (hderiv t ht).differentiableAt
  have hderiv_eq : Set.EqOn g (deriv f) (Set.Icc (2:ℝ) x) :=
    fun t ht => (hderiv t ht).deriv.symm
  have hgcont : ContinuousOn g (Set.Icc (2:ℝ) x) := by
    rw [hg_def]
    apply ContinuousOn.neg
    apply ContinuousOn.inv₀
    · exact continuousOn_id.pow 2
    · intro t ht
      have htpos : (0:ℝ) < t := by linarith [(Set.mem_Icc.mp ht).1]
      positivity
  have hf_int : MeasureTheory.IntegrableOn (deriv f) (Set.Icc (2:ℝ) x)
      MeasureTheory.volume := by
    apply MeasureTheory.IntegrableOn.congr_fun (f := g)
    · exact hgcont.integrableOn_Icc
    · exact hderiv_eq
    · exact measurableSet_Icc
  have hthetadef : ∀ y : ℝ, Chebyshev.theta y =
      ∑ k ∈ Finset.Icc 0 ⌊y⌋₊, c k := by
    intro y
    rw [Chebyshev.theta, hc_def, Finset.sum_filter]
    rw [show Finset.Icc 0 ⌊y⌋₊ = insert 0 (Finset.Ioc 0 ⌊y⌋₊) by
      ext k
      simp only [Finset.mem_Icc, Finset.mem_insert, Finset.mem_Ioc]
      omega]
    rw [Finset.sum_insert (by simp)]
    simp
  have h2le : 2 ≤ ⌊x⌋₊ := Nat.le_floor (by exact_mod_cast hx)
  have habel := sum_mul_eq_sub_sub_integral_mul c (by norm_num : (0:ℝ) ≤ 2)
    hx hf_diff hf_int
  have hfloor2 : ⌊(2:ℝ)⌋₊ = 2 := by norm_num
  rw [hfloor2] at habel
  have hset : (Finset.Icc 1 ⌊x⌋₊).filter Nat.Prime =
      insert 2 ((Finset.Ioc 2 ⌊x⌋₊).filter Nat.Prime) := by
    ext k
    simp only [Finset.mem_filter, Finset.mem_Icc, Finset.mem_insert, Finset.mem_Ioc]
    constructor
    · rintro ⟨⟨h1, hkn⟩, hp⟩
      have hk2 : 2 ≤ k := hp.two_le
      rcases eq_or_lt_of_le hk2 with heq | hlt
      · left
        exact heq.symm
      · right
        exact ⟨⟨hlt, hkn⟩, hp⟩
    · rintro (rfl | ⟨⟨h1, hkn⟩, hp⟩)
      · exact ⟨⟨by norm_num, h2le⟩, Nat.prime_two⟩
      · exact ⟨⟨by omega, hkn⟩, hp⟩
  have hLHS : ∑ k ∈ Finset.Ioc 2 ⌊x⌋₊, f (k:ℝ) * c k =
      (∑ p ∈ Finset.Icc 1 ⌊x⌋₊ with p.Prime, Real.log p / (p:ℝ)) -
        Real.log 2 / 2 := by
    have hfck : ∀ k ∈ Finset.Ioc 2 ⌊x⌋₊,
        f (k:ℝ) * c k =
          if k.Prime then Real.log k / (k:ℝ) else 0 := by
      intro k hk
      rw [hf_def, hc_def]
      by_cases hp : k.Prime
      · simp only [hp, if_true]
        ring
      · simp [hp]
    rw [Finset.sum_congr rfl hfck, ← Finset.sum_filter, hset,
      Finset.sum_insert (by simp)]
    norm_num
  rw [hLHS] at habel
  have hth2sum : ∑ k ∈ Finset.Icc 0 2, c k = Real.log 2 := by
    simp only [show Finset.Icc 0 2 = {0,1,2} by decide, Finset.sum_insert,
      Finset.sum_singleton]
    rw [hc_def]
    norm_num [Nat.prime_two]
  rw [hth2sum] at habel
  have hf2 : f 2 * Real.log 2 = Real.log 2 / 2 := by
    rw [hf_def]
    ring
  rw [← hthetadef x] at habel
  have hintsimp : ∫ t in Set.Ioc (2:ℝ) x,
      deriv f t * ∑ k ∈ Finset.Icc 0 ⌊t⌋₊, c k =
      ∫ t in Set.Ioc (2:ℝ) x, -(Chebyshev.theta t / t^2) := by
    apply MeasureTheory.setIntegral_congr_fun measurableSet_Ioc
    intro t ht
    dsimp only
    have ht' : t ∈ Set.Icc (2:ℝ) x :=
      Set.mem_Icc.mpr ⟨le_of_lt ht.1, ht.2⟩
    rw [← hderiv_eq ht', hg_def, ← hthetadef t]
    ring
  rw [hintsimp, MeasureTheory.integral_neg, hf2] at habel
  have hfxthm : f x * Chebyshev.theta x = Chebyshev.theta x / x := by
    rw [hf_def]
    ring
  linarith [habel, hfxthm]


end MathCorpus.NumberTheory.PrimeDistribution.ChebyshevTheta
