import Mathlib

/-!
Erdős #1052 companion infrastructure: σ* (unitary-divisor-sum) multiplicativity.

Transported from the sibling repo's `Erdos1052_sigmaStar_and_bounds.lean`
(mnehmos.llm-driven-proof-search.environment/ErdosProblems/erdos-1052/proof/),
independently re-verified through this repo's own tracked proof-search loop.
`uDiv`/`sigmaStar`/`mem_uDiv` are re-transported here (a SubmitModule is a
self-contained namespace and cannot reference declarations verified in a
different packet's module) -- see the companion packet
`erdos_1052_sigmastar_prime_pow_and_prime.v1` for the prime/prime-power
special cases proved from the same definitions.

This packet proves the general multiplicativity theorem
`sigmaStar (m * n) = sigmaStar m * sigmaStar n` for coprime nonzero `m, n`.
It does NOT prove Erdős #1052 itself (genuinely OPEN: are there finitely many
unitary perfect numbers?), and NOT yet the `omega_odd_le_two_adic_add_one`
structural bound that depends on this theorem (deferred to a future cycle),
nor the full Subbarao-Warren `even_of_isUnitaryPerfect` headline theorem.
-/

namespace MathCorpus.Frontier.Erdos

-- Module-local scope: sibling Erdos-1052 snapshots re-declare shared helpers
-- (uDiv, sigmaStar, ...); this inner namespace keeps the root import collision-free.
namespace SigmaStarMulOfCoprime

def uDiv : ℕ → Finset ℕ :=
  fun n => n.divisors.filter (fun d => Nat.Coprime d (n / d))

theorem mem_uDiv : ∀ {n d : ℕ}, n ≠ 0 → (d ∈ uDiv n ↔ d ∣ n ∧ Nat.Coprime d (n / d)) := by
  intro n d hn
  simp [uDiv, Nat.mem_divisors, hn]

def sigmaStar : ℕ → ℕ :=
  fun n => ∑ d ∈ uDiv n, d

theorem split_dvd_mul :
    ∀ {m n d : ℕ}, m.Coprime n → d ∣ m * n → Nat.gcd d m * Nat.gcd d n = d := by
  intro m n d hmn hd
  exact (Nat.gcd_mul_gcd_eq_iff_dvd_mul_of_coprime hmn).mpr hd

theorem quot_mul_quot :
    ∀ {x y a b : ℕ}, a ∣ x → b ∣ y → (x / a) * (y / b) = x * y / (a * b) := by
  intro x y a b ha hb
  obtain ⟨x', rfl⟩ := ha
  obtain ⟨y', rfl⟩ := hb
  rcases Nat.eq_zero_or_pos a with rfl | ha0
  simp
  rcases Nat.eq_zero_or_pos b with rfl | hb0
  simp
  rw [Nat.mul_div_cancel_left _ ha0, Nat.mul_div_cancel_left _ hb0]
  rw [show a * x' * (b * y') = (a * b) * (x' * y') by ring]
  rw [Nat.mul_div_cancel_left _ (Nat.mul_pos ha0 hb0)]

theorem gcd_mul_left_eq :
    ∀ {x y a b : ℕ}, a ∣ x → b ∣ y → x.Coprime y → Nat.gcd (a * b) x = a := by
  intro x y a b ha hb hxy
  have hbx : b.Coprime x := (hxy.symm.coprime_dvd_left hb)
  refine Nat.dvd_antisymm ?_ (Nat.dvd_gcd (Dvd.intro b rfl) ha)
  have hcop : (Nat.gcd (a * b) x).Coprime b :=
    (hbx.coprime_dvd_right (Nat.gcd_dvd_right (a * b) x)).symm
  exact hcop.dvd_of_dvd_mul_right (Nat.gcd_dvd_left (a * b) x)

/-- **σ* is multiplicative**: for coprime, nonzero `m, n`, `σ*(mn) = σ*(m)·σ*(n)`. -/
theorem sigmaStar_mul_of_coprime :
    ∀ {m n : ℕ}, m ≠ 0 → n ≠ 0 → m.Coprime n → sigmaStar (m * n) = sigmaStar m * sigmaStar n := by
  intro m n hm hn hmn
  have hmn0 : m * n ≠ 0 := mul_ne_zero hm hn
  unfold sigmaStar
  rw [Finset.sum_mul_sum, ← Finset.sum_product']
  refine Finset.sum_nbij' (fun d => (Nat.gcd d m, Nat.gcd d n)) (fun p => p.1 * p.2) ?_ ?_ ?_ ?_ ?_
  intro d hd
  rw [mem_uDiv hmn0] at hd
  obtain ⟨hddvd, hdcop⟩ := hd
  have hsplit := split_dvd_mul hmn hddvd
  have hg1dvd : Nat.gcd d m ∣ m := Nat.gcd_dvd_right d m
  have hg2dvd : Nat.gcd d n ∣ n := Nat.gcd_dvd_right d n
  have hquot : (m / Nat.gcd d m) * (n / Nat.gcd d n) = m * n / d :=
    (by rw [quot_mul_quot hg1dvd hg2dvd, hsplit])
  have hcop1 : Nat.gcd (Nat.gcd d m) (m / Nat.gcd d m) ∣ Nat.gcd d (m * n / d) :=
    (Nat.dvd_gcd
      ((Nat.gcd_dvd_left (Nat.gcd d m) (m / Nat.gcd d m)).trans (Nat.gcd_dvd_left d m))
      (by
        refine (Nat.gcd_dvd_right (Nat.gcd d m) (m / Nat.gcd d m)).trans ?_
        rw [← hquot]
        exact dvd_mul_right _ _))
  have hcop2 : Nat.gcd (Nat.gcd d n) (n / Nat.gcd d n) ∣ Nat.gcd d (m * n / d) :=
    (Nat.dvd_gcd
      ((Nat.gcd_dvd_left (Nat.gcd d n) (n / Nat.gcd d n)).trans (Nat.gcd_dvd_left d n))
      (by
        refine (Nat.gcd_dvd_right (Nat.gcd d n) (n / Nat.gcd d n)).trans ?_
        rw [← hquot]
        exact dvd_mul_left _ _))
  have hdcop1 : Nat.gcd d (m * n / d) = 1 := hdcop
  simp only [Finset.mem_product]
  exact ⟨(mem_uDiv hm).mpr ⟨hg1dvd, Nat.dvd_one.mp (hdcop1 ▸ hcop1)⟩,
         (mem_uDiv hn).mpr ⟨hg2dvd, Nat.dvd_one.mp (hdcop1 ▸ hcop2)⟩⟩
  intro p hp
  simp only [Finset.mem_product] at hp
  obtain ⟨hp1, hp2⟩ := hp
  rw [mem_uDiv hm] at hp1
  rw [mem_uDiv hn] at hp2
  obtain ⟨hd1dvd, hd1cop⟩ := hp1
  obtain ⟨hd2dvd, hd2cop⟩ := hp2
  rw [mem_uDiv hmn0]
  refine ⟨Nat.mul_dvd_mul hd1dvd hd2dvd, ?_⟩
  have hquot2 : (m / p.1) * (n / p.2) = m * n / (p.1 * p.2) := quot_mul_quot hd1dvd hd2dvd
  rw [← hquot2]
  have hcross1 : p.1.Coprime (n / p.2) :=
    (hmn.coprime_dvd_left hd1dvd).coprime_dvd_right (Nat.div_dvd_of_dvd hd2dvd)
  have hcross2 : p.2.Coprime (m / p.1) :=
    ((hmn.coprime_dvd_right hd2dvd).coprime_dvd_left (Nat.div_dvd_of_dvd hd1dvd)).symm
  exact (hd1cop.mul_right hcross1).mul (hcross2.mul_right hd2cop)
  intro d hd
  rw [mem_uDiv hmn0] at hd
  exact split_dvd_mul hmn hd.1
  intro p hp
  simp only [Finset.mem_product] at hp
  obtain ⟨hp1, hp2⟩ := hp
  rw [mem_uDiv hm] at hp1
  rw [mem_uDiv hn] at hp2
  have e1 : Nat.gcd (p.1 * p.2) m = p.1 := gcd_mul_left_eq hp1.1 hp2.1 hmn
  have e2 : Nat.gcd (p.1 * p.2) n = p.2 := (by rw [mul_comm]; exact gcd_mul_left_eq hp2.1 hp1.1 hmn.symm)
  exact Prod.ext e1 e2
  intro d hd
  rw [mem_uDiv hmn0] at hd
  exact (split_dvd_mul hmn hd.1).symm

end SigmaStarMulOfCoprime

end MathCorpus.Frontier.Erdos
