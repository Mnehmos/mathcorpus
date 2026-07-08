import Mathlib
/-!
# Erdős #291 companion, part (ii) (Steinerberger): gcd(aₙ,Lₙ)>1 infinitely often

Packet: `frontier.erdos.erdos_291_infinite_gcd_gt_one.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Erdős #291 (open): with `L_n = lcm(1,…,n)` and `a_n` defined by
`∑_{1≤k≤n} 1/k = a_n / L_n`, is `gcd(a_n, L_n) = 1` for infinitely many
`n`? This file proves only part (ii) — the EASY, already-known direction
(Steinerberger): `gcd(a_n, L_n) > 1` occurs for infinitely many `n`. We do
**not** resolve the open part (i).

## Construction

Take `n = 2·3^k` (`k ≥ 1`). Then `v₃(L_n) = k`, so in
`a_n = ∑_{j=1}^n L_n/j` every term `L_n/j` is divisible by 3 EXCEPT the
two with `3^k ∣ j`, namely `j = 3^k` and `j = 2·3^k`. Writing
`L_n = 3^k · M` (`3 ∤ M`, `2 ∣ M`), those two contributions are
`M + M/2 = 3·(M/2) ≡ 0 (mod 3)`. Hence `3 ∣ a_n`; also `3 ∣ L_n`, so
`3 ∣ gcd(a_n, L_n)`. The map `k ↦ 2·3^k` is injective, so the set is
infinite.

Kernel-verified through the tracked proof-search loop (episode
2f8943e6), re-proving (independently in this environment's own pinned
toolchain) the result already Lean-verified in the sibling repo at
`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\erdos-291\proof\Erdos291_infinite_gcd_gt_one.lean`.
The transport needed all inline `have h := by tac1; tac2` assignments
followed by more sibling tactics to be parenthesized (`have h := (by
tac1; tac2)`) — helper module items are always transported via the
flattener, which otherwise mis-scopes the trailing tactics into the
inner `by` block (issue #67's flattened-sequence trap, at a larger scale
than previously seen in this corpus).
-/

namespace MathCorpus.Frontier.Erdos

/-- `L n` is the least common multiple of `{1,…,n}`. -/
def L (n : ℕ) : ℕ := (Finset.Icc 1 n).lcm (fun x => x)

/-- `a n` defined by `∑_{1≤k≤n} 1/k = a n / L n`. -/
def a (n : ℕ) : ℕ := ∑ k ∈ Finset.Icc 1 n, L n / k

/-- `L n ≠ 0`: the lcm of a set of positive numbers. -/
theorem L_ne_zero (n : ℕ) : L n ≠ 0 := by
  rw [L, Finset.lcm_ne_zero_iff]
  intro i hi
  simp only [Finset.mem_Icc] at hi
  omega

/-- Every `j ∈ {1,…,n}` divides `L n`. -/
theorem dvd_L {j n : ℕ} (h : j ∈ Finset.Icc 1 n) : j ∣ L n := by
  rw [L]; exact Finset.dvd_lcm h

/-- `3 ∣ L n` whenever `3 ≤ n`. -/
theorem three_dvd_L {n : ℕ} (hn : 3 ≤ n) : 3 ∣ L n :=
  dvd_L (by simp only [Finset.mem_Icc]; omega)

/-- The multiples of `3^k` in `{1, …, 2·3^k}` are exactly `3^k` and `2·3^k`. -/
theorem filter_multiples (k : ℕ) :
    (Finset.Icc 1 (2 * 3 ^ k)).filter (fun j => 3 ^ k ∣ j)
      = ({3 ^ k, 2 * 3 ^ k} : Finset ℕ) := by
  have hpos : 0 < 3 ^ k := pow_pos (by norm_num) k
  have hmp : ∀ j, (1 ≤ j ∧ j ≤ 2 * 3 ^ k) ∧ 3 ^ k ∣ j → j = 3 ^ k ∨ j = 2 * 3 ^ k := by
    intro j hj
    obtain ⟨⟨hj1, hj2⟩, t, rfl⟩ := hj
    rw [mul_comm 2 (3 ^ k)] at hj2
    have hle : t ≤ 2 := Nat.le_of_mul_le_mul_left hj2 hpos
    have ht0 : t ≠ 0 := fun h0 => by rw [h0] at hj1; simp at hj1
    have hge : 1 ≤ t := Nat.one_le_iff_ne_zero.mpr ht0
    have ht2 : t = 1 ∨ t = 2 := by omega
    exact ht2.elim (fun h => Or.inl (by rw [h]; ring)) (fun h => Or.inr (by rw [h]; ring))
  have hmpr : ∀ j, j = 3 ^ k ∨ j = 2 * 3 ^ k → (1 ≤ j ∧ j ≤ 2 * 3 ^ k) ∧ 3 ^ k ∣ j := by
    intro j hj
    exact hj.elim (fun h => by rw [h]; exact ⟨⟨hpos, by omega⟩, dvd_refl _⟩)
      (fun h => by rw [h]; exact ⟨⟨by omega, le_refl _⟩, ⟨2, by ring⟩⟩)
  ext j
  simp only [Finset.mem_filter, Finset.mem_Icc, Finset.mem_insert, Finset.mem_singleton]
  exact ⟨hmp j, hmpr j⟩

/-- **Crux.** For `n = 2·3^k` (`k ≥ 1`), `3 ∣ a n`. -/
theorem three_dvd_a (k : ℕ) : 3 ∣ a (2 * 3 ^ k) := by
  have prime3 : Nat.Prime 3 := by norm_num
  have hpos : 0 < 3 ^ k := pow_pos (by norm_num) k
  have hLne : L (2 * 3 ^ k) ≠ 0 := L_ne_zero _
  have h3k_dvd_L : 3 ^ k ∣ L (2 * 3 ^ k) :=
    dvd_L (by simp only [Finset.mem_Icc]; exact ⟨hpos, by omega⟩)
  have vL : k ≤ (L (2 * 3 ^ k)).factorization 3 :=
    (Nat.Prime.pow_dvd_iff_le_factorization prime3 hLne).mp h3k_dvd_L
  have hvanish : ∀ j ∈ (Finset.Icc 1 (2 * 3 ^ k)).filter (fun j => ¬ 3 ^ k ∣ j),
      3 ∣ L (2 * 3 ^ k) / j := by
    intro j hj
    simp only [Finset.mem_filter, Finset.mem_Icc] at hj
    obtain ⟨⟨hj1, hj2⟩, hjnk⟩ := hj
    have hj_dvd : j ∣ L (2 * 3 ^ k) := dvd_L (by simp only [Finset.mem_Icc]; exact ⟨hj1, hj2⟩)
    have hj_ne : j ≠ 0 := by omega
    have hvj : (j).factorization 3 < k := by
      by_contra h
      exact hjnk ((Nat.Prime.pow_dvd_iff_le_factorization prime3 hj_ne).mpr (not_lt.mp h))
    have hquot_pos : 0 < L (2 * 3 ^ k) / j :=
      Nat.div_pos (Nat.le_of_dvd (Nat.pos_of_ne_zero hLne) hj_dvd) (by omega)
    have hone : 1 ≤ (L (2 * 3 ^ k) / j).factorization 3 := by
      rw [Nat.factorization_div hj_dvd]
      simp only [Finsupp.coe_tsub, Pi.sub_apply]
      omega
    exact (Nat.Prime.dvd_iff_one_le_factorization prime3 hquot_pos.ne').mpr hone
  have hLn_dvd : 2 * 3 ^ k ∣ L (2 * 3 ^ k) := by
    have hcop : Nat.Coprime 2 (3 ^ k) := Nat.Coprime.pow_right k (by norm_num)
    have h2 : 2 ∣ L (2 * 3 ^ k) := dvd_L (by simp only [Finset.mem_Icc]; omega)
    exact Nat.Coprime.mul_dvd_of_dvd_of_dvd hcop h2 h3k_dvd_L
  obtain ⟨t, ht⟩ := hLn_dvd
  have e1 : L (2 * 3 ^ k) / 3 ^ k = 2 * t := by
    rw [ht, show 2 * 3 ^ k * t = 3 ^ k * (2 * t) by ring, Nat.mul_div_cancel_left _ hpos]
  have e2 : L (2 * 3 ^ k) / (2 * 3 ^ k) = t := by
    rw [ht, Nat.mul_div_cancel_left _ (by positivity)]
  have hfirst : 3 ∣ (L (2 * 3 ^ k) / 3 ^ k + L (2 * 3 ^ k) / (2 * 3 ^ k)) := by
    rw [e1, e2]; exact ⟨t, by ring⟩
  have hsecond : 3 ∣ ∑ j ∈ (Finset.Icc 1 (2 * 3 ^ k)).filter (fun j => ¬ 3 ^ k ∣ j),
      L (2 * 3 ^ k) / j := Finset.dvd_sum hvanish
  rw [a, ← Finset.sum_filter_add_sum_filter_not (Finset.Icc 1 (2 * 3 ^ k)) (fun j => 3 ^ k ∣ j),
    filter_multiples k, Finset.sum_insert (by simp only [Finset.mem_singleton]; omega),
    Finset.sum_singleton]
  exact Nat.dvd_add hfirst hsecond

/-- **Erdős #291, part (ii).** `gcd(aₙ, Lₙ) > 1` for infinitely many `n`
(Steinerberger; the easy already-known direction). We do *not* resolve
the open part (i). -/
theorem erdos_291_infinite_gcd_gt_one :
    {n : ℕ | 1 < Nat.gcd (a n) (L n)}.Infinite := by
  apply Set.infinite_of_injective_forall_mem
    (f := fun k : ℕ => 2 * 3 ^ (k + 1))
  · intro x y hxy
    simp only [] at hxy
    have h3 : 3 ^ (x + 1) = 3 ^ (y + 1) := by omega
    have := Nat.pow_right_injective (by norm_num) h3
    omega
  · intro k
    have ha := three_dvd_a (k + 1)
    have hL : 3 ∣ L (2 * 3 ^ (k + 1)) :=
      three_dvd_L (by have := pow_pos (show 0 < 3 by norm_num) (k + 1); omega)
    obtain ⟨c, hc⟩ := Nat.dvd_gcd ha hL
    have hgpos : 0 < Nat.gcd (a (2 * 3 ^ (k + 1))) (L (2 * 3 ^ (k + 1))) :=
      Nat.gcd_pos_of_pos_right _ (Nat.pos_of_ne_zero (L_ne_zero _))
    simp only [Set.mem_setOf_eq]
    omega

end MathCorpus.Frontier.Erdos
