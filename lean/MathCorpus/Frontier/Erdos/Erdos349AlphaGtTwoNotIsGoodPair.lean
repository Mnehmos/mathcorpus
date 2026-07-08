import Mathlib
/-!
# Erdős #349 assembly piece: α > 2 fails to be a good pair

Packet: `frontier.erdos.erdos_349_alpha_gt_two_not_is_good_pair.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

The fourth and final assembly piece supporting Erdős #349's
`integer_isGoodPair_iff` characterization: if `α > 2` (with `t > 0`), the
pair `(t, α)` is **not** good. This is infrastructure supporting #349,
not a resolution of the problem itself (which remains genuinely open in
general).

## Proof idea

The sequence `f(n) = ⌊t·α^n⌋` grows fast enough (since `α > 2`) that
`f(n+1)` eventually exceeds `S(n) + 2`, where `S(n) = ∑_{k≤n} f(k)` is the
running partial sum. This creates an unreachable gap: `S(n) + 1` is not
expressible as a subset sum of `{f(0),…,f(n),f(n+1),…}` for infinitely
many `n` — no subset either stays below `S(n)+1` (bounded by `S(n)`
itself) or reaches `f(n+1)` (which overshoots to at least `S(n)+2`).
This contradicts eventual representability of every large integer.

Kernel-verified through the tracked proof-search loop (episode
65b19a8e), re-proving (independently in this environment's own pinned
toolchain, on the FIRST attempt) the result already Lean-verified in the
sibling repo at
`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\erdos-349\proof\Erdos349_alpha_gt_two_not_isGoodPair.lean`
(which itself needed 3 tracked attempts there).
-/

namespace MathCorpus.Frontier.Erdos

theorem erdos_349_alpha_gt_two_not_is_good_pair :
    ∀ (t α : ℝ), 0 < t → 2 < α →
    ¬ (∀ᶠ k in Filter.atTop, k ∈ {n : ℤ | ∃ B : Finset ℤ,
      ↑B ⊆ Set.range (fun n : ℕ ↦ ⌊t * α ^ n⌋) ∧ n = ∑ i ∈ B, i}) := by
  intro t α ht hα
  set f : ℕ → ℤ := fun n => ⌊t * α ^ n⌋ with hf
  have hα0 : (0 : ℝ) < α := by linarith
  have hα1 : (1 : ℝ) < α := by linarith
  have hα1' : (1 : ℝ) ≤ α := le_of_lt hα1
  have hαm1 : (0 : ℝ) < α - 1 := by linarith
  have hnonneg : ∀ n, 0 ≤ f n := by
    intro n
    rw [hf]
    exact Int.floor_nonneg.mpr (by positivity)
  have hterm_le : ∀ k, (f k : ℝ) ≤ t * α ^ k := by
    intro k
    rw [hf]
    exact Int.floor_le _
  have hmono : Monotone f := by
    intro n m hnm
    rw [hf]
    apply Int.floor_le_floor
    exact mul_le_mul_of_nonneg_left (pow_le_pow_right₀ hα1' hnm) (le_of_lt ht)
  set S : ℕ → ℤ := fun n => ∑ k ∈ Finset.range (n + 1), f k with hS
  have hSbound : ∀ n, (S n : ℝ) ≤ t * α ^ (n + 1) / (α - 1) := by
    intro n
    have h1 : (S n : ℝ) = ∑ k ∈ Finset.range (n + 1), (f k : ℝ) := by
      rw [hS]
      push_cast
      rfl
    rw [h1]
    have h2 : ∑ k ∈ Finset.range (n + 1), (f k : ℝ) ≤ ∑ k ∈ Finset.range (n + 1), t * α ^ k := by
      apply Finset.sum_le_sum
      intro k _
      exact hterm_le k
    refine le_trans h2 ?_
    have h3 : ∑ k ∈ Finset.range (n + 1), t * α ^ k = t * ((α ^ (n + 1) - 1) / (α - 1)) := by
      rw [← Finset.mul_sum, geom_sum_eq (by linarith : α ≠ 1)]
    rw [h3]
    rw [mul_div_assoc]
    apply mul_le_mul_of_nonneg_left _ (le_of_lt ht)
    apply div_le_div_of_nonneg_right (by linarith) hαm1.le
  rw [Filter.not_eventually]
  rw [Filter.frequently_atTop]
  intro N
  have htend : Filter.Tendsto (fun n : ℕ => t * α ^ (n + 1) * ((α - 2) / (α - 1)) - 2)
      Filter.atTop Filter.atTop := by
    have hpow : Filter.Tendsto (fun n : ℕ => α ^ (n + 1)) Filter.atTop Filter.atTop :=
      (tendsto_pow_atTop_atTop_of_one_lt hα1).comp (Filter.tendsto_add_atTop_nat 1)
    have hc2 : (0 : ℝ) < (α - 2) / (α - 1) := by
      apply _root_.div_pos <;> linarith
    have h1 : Filter.Tendsto (fun n : ℕ => t * α ^ (n + 1)) Filter.atTop Filter.atTop :=
      hpow.const_mul_atTop ht
    have h2 : Filter.Tendsto (fun n : ℕ => t * α ^ (n + 1) * ((α - 2) / (α - 1)))
        Filter.atTop Filter.atTop := h1.atTop_mul_const hc2
    exact Filter.tendsto_atTop_add_const_right Filter.atTop (-2 : ℝ)
      (by simpa [sub_eq_add_neg] using h2)
  have htend2 : Filter.Tendsto (fun n : ℕ => t * α ^ n - 1) Filter.atTop Filter.atTop := by
    have hpow : Filter.Tendsto (fun n : ℕ => α ^ n) Filter.atTop Filter.atTop :=
      tendsto_pow_atTop_atTop_of_one_lt hα1
    have h1 : Filter.Tendsto (fun n : ℕ => t * α ^ n) Filter.atTop Filter.atTop :=
      hpow.const_mul_atTop ht
    exact Filter.tendsto_atTop_add_const_right Filter.atTop (-1 : ℝ)
      (by simpa [sub_eq_add_neg] using h1)
  have hev := (htend.eventually_ge_atTop (max ((N : ℝ) + 2) 3)).and
    (htend2.eventually_ge_atTop ((N : ℝ)))
  obtain ⟨n, hn, hn2⟩ := hev.exists
  have hn' : (N : ℝ) + 2 ≤ t * α ^ (n + 1) * ((α - 2) / (α - 1)) - 2 := le_trans (le_max_left _ _) hn
  have hn3 : (3 : ℝ) ≤ t * α ^ (n + 1) * ((α - 2) / (α - 1)) - 2 := le_trans (le_max_right _ _) hn
  have ha_lb : t * α ^ (n + 1) - 1 < (f (n + 1) : ℝ) := by
    have := Int.sub_one_lt_floor (t * α ^ (n + 1))
    rw [hf]
    exact this
  have hreal : (f (n + 1) : ℝ) - (S n : ℝ) - 1 > t * α ^ (n + 1) * ((α - 2) / (α - 1)) - 2 := by
    have hsb := hSbound n
    have key : t * α ^ (n + 1) * ((α - 2) / (α - 1)) = t * α ^ (n + 1) - t * α ^ (n + 1) / (α - 1) := by
      field_simp
      ring
    rw [key]
    linarith [ha_lb, hsb]
  have hcombine : (f (n + 1) : ℝ) - (S n : ℝ) - 1 > (N : ℝ) + 2 := by
    linarith [hreal, hn']
  have hgapR : (f (n + 1) : ℝ) - (S n : ℝ) - 1 > 3 := by
    linarith [hreal, hn3]
  have hgap : f (n + 1) ≥ S n + 2 := by
    have : ((f (n + 1) - (S n) : ℤ) : ℝ) ≥ ((2 : ℤ) : ℝ) := by
      push_cast
      linarith [hgapR]
    have h2 : (f (n + 1) - (S n) : ℤ) ≥ (2 : ℤ) := by
      exact_mod_cast this
    linarith
  have hSn_lb : (S n : ℝ) ≥ t * α ^ n - 1 := by
    have hlast : f n ≤ S n := by
      rw [hS]
      apply Finset.single_le_sum (fun i _ => hnonneg i)
      simp
    have h1 : (f n : ℝ) ≥ t * α ^ n - 1 := by
      have := Int.sub_one_lt_floor (t * α ^ n)
      have : (t * α ^ n) - 1 ≤ (⌊t * α ^ n⌋ : ℝ) := le_of_lt this
      rw [hf]
      simpa using this
    have h2 : (f n : ℝ) ≤ (S n : ℝ) := by exact_mod_cast hlast
    linarith
  have hSnN : (S n) ≥ N := by
    have : (S n : ℝ) ≥ (N : ℝ) := le_trans hn2 hSn_lb
    exact_mod_cast this
  refine ⟨S n + 1, ?_, ?_⟩
  · linarith
  · rintro ⟨B, hBsub, hBsum⟩
    have hBnonneg : ∀ b ∈ B, (0 : ℤ) ≤ b := by
      intro b hb
      have : b ∈ Set.range f := hBsub hb
      obtain ⟨m, rfl⟩ := this
      exact hnonneg m
    set P : ℤ := f (n + 1) with hP
    by_cases hcase : ∃ b ∈ B, P ≤ b
    · obtain ⟨b, hbB, hPb⟩ := hcase
      have hge : P ≤ ∑ i ∈ B, i := by
        calc P ≤ b := hPb
          _ ≤ ∑ i ∈ B, i := Finset.single_le_sum (fun i hi => hBnonneg i hi) hbB
      have hSgeP : S n + 1 ≥ P := by
        rw [hBsum]
        exact hge
      have hleP : S n + 2 ≤ P := by
        simpa [hP] using hgap
      have : S n + 2 ≤ S n + 1 := le_trans hleP hSgeP
      omega
    · have hlt : ∀ b ∈ B, b < P := by
        intro b hb
        by_contra hc
        exact hcase ⟨b, hb, not_lt.mp hc⟩
      have hBsubimg : B ⊆ (Finset.range (n + 1)).image f := by
        intro b hb
        have hbP : b < P := hlt b hb
        have : b ∈ Set.range f := hBsub hb
        obtain ⟨m, rfl⟩ := this
        have hmle : m ≤ n := by
          by_contra hmn
          have : f (n + 1) ≤ f m := hmono (by omega)
          rw [← hP] at this
          omega
        rw [Finset.mem_image]
        exact ⟨m, Finset.mem_range.mpr (by omega), rfl⟩
      have himg_le : ∑ u ∈ (Finset.range (n + 1)).image f, u ≤ S n := by
        have h := Finset.sum_image_le_of_nonneg (s := Finset.range (n + 1)) (g := f)
          (f := fun x : ℤ => x) (fun u hu => by
            rw [Finset.mem_image] at hu
            obtain ⟨m, _, rfl⟩ := hu
            exact hnonneg m)
        simpa [hS] using h
      have hBsum_le : ∑ i ∈ B, i ≤ S n := by
        calc ∑ i ∈ B, i ≤ ∑ u ∈ (Finset.range (n + 1)).image f, u :=
            Finset.sum_le_sum_of_subset_of_nonneg hBsubimg (fun i hi _ => by
              rw [Finset.mem_image] at hi
              obtain ⟨m, _, rfl⟩ := hi
              exact hnonneg m)
          _ ≤ S n := himg_le
      rw [← hBsum] at hBsum_le
      omega

end MathCorpus.Frontier.Erdos
