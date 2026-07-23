import Mathlib

/-!
Erdős #1052 companion infrastructure: the odd-prime-factor-count structural bound.

Transported from the sibling repo's `Erdos1052_sigmaStar_and_bounds.lean`
(mnehmos.llm-driven-proof-search.environment/ErdosProblems/erdos-1052/proof/),
independently re-verified through this repo's own tracked proof-search loop.
`uDiv`/`sigmaStar`/`mem_uDiv`/`split_dvd_mul`/`quot_mul_quot`/`gcd_mul_left_eq`/
`sigmaStar_mul_of_coprime`/`sigmaStar_prime_pow` are re-transported here (a
SubmitModule is a self-contained namespace and cannot reference declarations
verified in a different packet's module) -- see the companion packets
`erdos_1052_sigmastar_mul_of_coprime.v1` and
`erdos_1052_sigmastar_prime_pow_and_prime.v1` for those pieces standalone.

This packet adds `two_pow_card_primeFactors_dvd_sigmaStar` (proved by strong
induction: peel off the full power of the smallest prime factor at each step)
and the headline structural bound `omega_odd_le_two_adic_add_one`: if
`2^a * m` (`m` odd, `a >= 1`) is a unitary perfect number (`sigmaStar = 2n`),
then `m` has at most `a + 1` distinct odd prime factors. Combined with Wall's
1988 theorem (>= 9 odd prime factors needed for a sixth unitary perfect
number), this forces `a >= 8` for any sixth unitary perfect number -- it
narrows the search space, it does NOT resolve the open finiteness question
(are there finitely many unitary perfect numbers?), and it does NOT prove
Erdős #1052 itself or the full Subbarao-Warren `even_of_isUnitaryPerfect`
headline theorem.
-/

namespace MathCorpus.Frontier.Erdos

-- Module-local scope: sibling Erdos-1052 snapshots re-declare shared helpers
-- (uDiv, sigmaStar, ...); this inner namespace keeps the root import collision-free.
namespace OmegaOddLeTwoAdicAddOne

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

theorem sigmaStar_prime_pow :
    ∀ {p e : ℕ}, p.Prime → 1 ≤ e → sigmaStar (p ^ e) = p ^ e + 1 := by
  intro p e hp he
  have hpe : p ^ e ≠ 0 := (pow_pos hp.pos e).ne'
  unfold sigmaStar
  have heq : uDiv (p ^ e) = {1, p ^ e} :=
    (by
      ext d
      rw [mem_uDiv hpe]
      simp only [Finset.mem_insert, Finset.mem_singleton]
      constructor
      rintro ⟨hdvd, hcop⟩
      obtain ⟨k, hk, rfl⟩ := (Nat.dvd_prime_pow hp).mp hdvd
      rcases Nat.eq_zero_or_pos k with rfl | hk0
      left; simp
      right
      by_contra hne
      have hklt : k < e :=
        (by
          rcases lt_or_eq_of_le hk with h | h
          exact h
          exact absurd (by rw [h]) hne)
      have hexp : p ^ e = p ^ k * p ^ (e - k) :=
        (by rw [← pow_add]; congr 1; omega)
      have hp_dvd_quot : p ∣ p ^ e / p ^ k :=
        (by
          rw [hexp, Nat.mul_div_cancel_left _ (pow_pos hp.pos k)]
          exact dvd_pow_self p (Nat.sub_ne_zero_of_lt hklt))
      have hp_dvd_self : p ∣ p ^ k := dvd_pow_self p hk0.ne'
      have hcontra : p ∣ Nat.gcd (p ^ k) (p ^ e / p ^ k) := Nat.dvd_gcd hp_dvd_self hp_dvd_quot
      rw [hcop] at hcontra
      exact hp.one_lt.ne' (Nat.eq_one_of_dvd_one hcontra) |>.elim
      rintro (rfl | rfl)
      exact ⟨one_dvd _, by simp⟩
      exact ⟨dvd_refl _, by simp [Nat.div_self (Nat.pos_of_ne_zero hpe)]⟩)
  rw [heq]
  have h1e : (1:ℕ) ≠ p ^ e :=
    (by
      have hgt : 1 < p ^ e := Nat.one_lt_pow (by omega) hp.one_lt
      omega)
  rw [Finset.sum_insert (Finset.mem_singleton.not.mpr h1e), Finset.sum_singleton]
  omega

/-- **The odd-prime-factor-count bound.** For `m` odd, `2 ^ m.primeFactors.card ∣ σ*(m)`.
Proved by strong induction: peel off the full power of the smallest prime factor at
each step. -/
theorem two_pow_card_primeFactors_dvd_sigmaStar :
    ∀ m : ℕ, Odd m → 2 ^ m.primeFactors.card ∣ sigmaStar m := by
  intro m
  induction' m using Nat.strong_induction_on with m ih
  intro hmodd
  rcases eq_or_ne m 1 with rfl | hm1
  simp [sigmaStar, uDiv]
  have hm0 : m ≠ 0 := (by rintro rfl; simp at hmodd)
  set p := m.minFac with hpdef
  have hp : p.Prime := Nat.minFac_prime hm1
  have hpodd : p ≠ 2 :=
    (by
      intro hp2
      have h2dvd : (2:ℕ) ∣ m := hp2 ▸ Nat.minFac_dvd m
      rw [Nat.odd_iff] at hmodd
      rw [Nat.dvd_iff_mod_eq_zero] at h2dvd
      omega)
  set e := m.factorization p with hedef
  have he1 : 1 ≤ e :=
    (by
      by_contra hlt
      push_neg at hlt
      have he0 : e = 0 := (by omega)
      rw [hedef] at he0
      rw [Nat.factorization_eq_zero_iff m p] at he0
      rcases he0 with h | h | h
      exact h hp
      exact h (Nat.minFac_dvd m)
      exact hm0 h)
  set m' := ordCompl[p] m with hm'def
  have hsplit : ordProj[p] m * m' = m := Nat.ordProj_mul_ordCompl_eq_self m p
  have hprojeq : ordProj[p] m = p ^ e := rfl
  have hm'pos : 0 < m' := Nat.ordCompl_pos p hm0
  have hcopm' : p.Coprime m' := Nat.coprime_ordCompl hp hm0
  have hm'odd : Odd m' :=
    (by
      rcases Nat.even_or_odd m' with he' | ho'
      exfalso
      have h2dvd : (2:ℕ) ∣ m' := he'.two_dvd
      have hm2dvd : (2:ℕ) ∣ m := h2dvd.trans (Dvd.intro_left _ hsplit)
      rw [Nat.odd_iff] at hmodd
      omega
      exact ho')
  have hm'lt : m' < m :=
    (by
      rw [← hsplit, hprojeq]
      have hpge : 2 ≤ p ^ e := le_trans hp.two_le (Nat.le_self_pow (by omega) p)
      nlinarith [hm'pos])
  have hcard : m.primeFactors.card = m'.primeFactors.card + 1 :=
    (by
      have hpf : m.primeFactors = insert p m'.primeFactors :=
        (by
          rw [← hsplit, hprojeq]
          rw [Nat.primeFactors_mul (pow_pos hp.pos e).ne' hm'pos.ne']
          rw [Nat.primeFactors_prime_pow (by omega) hp]
          rw [Finset.singleton_union])
      rw [hpf, Finset.card_insert_of_notMem]
      intro hmem
      exact absurd hmem (by
        rw [Nat.mem_primeFactors]
        push_neg
        intro _
        exact fun h => absurd h (by
          have hsymm := hcopm'.symm
          rwa [Nat.coprime_comm, Nat.Prime.coprime_iff_not_dvd hp] at hsymm)))
  have hihm' := ih m' hm'lt hm'odd
  have hmulcop : (p ^ e).Coprime m' := hcopm'.pow_left e
  have hsigma_eq : sigmaStar m = (p ^ e + 1) * sigmaStar m' :=
    (by
      rw [← hsplit, hprojeq, sigmaStar_mul_of_coprime (pow_pos hp.pos e).ne' hm'pos.ne' hmulcop,
          sigmaStar_prime_pow hp he1])
  have hpe_even : Even (p ^ e + 1) :=
    (by
      have hpodd2 : Odd p :=
        (by
          rw [← Nat.not_even_iff_odd]
          intro heven
          have h2dvd : (2:ℕ) ∣ p := even_iff_two_dvd.mp heven
          exact hpodd ((Nat.prime_dvd_prime_iff_eq Nat.prime_two hp).mp h2dvd).symm)
      have hodd2 : Odd (p ^ e) := hpodd2.pow
      rcases hodd2 with ⟨k, hk⟩
      exact ⟨k + 1, by omega⟩)
  rw [hcard, hsigma_eq]
  obtain ⟨c, hc⟩ := hpe_even
  rw [hc]
  have hre : (c + c) * sigmaStar m' = 2 * (c * sigmaStar m') := (by ring)
  rw [hre, pow_succ']
  exact Nat.mul_dvd_mul_left 2 (hihm'.mul_left c)

/-- **The headline bound.** If `2^a * m` (with `m` odd, `a ≥ 1`) is a unitary perfect
number (`sigmaStar = 2n`), then the number of distinct odd prime factors of `m` is at
most `a + 1`. -/
theorem omega_odd_le_two_adic_add_one (a m : ℕ) (hm_odd : Odd m) (ha : 0 < a)
    (hperfect : sigmaStar (2 ^ a * m) = 2 * (2 ^ a * m)) :
    m.primeFactors.card ≤ a + 1 := by
  have hm0 : m ≠ 0 := hm_odd.pos.ne'
  have h2apos : (2:ℕ) ^ a ≠ 0 := (pow_pos (by norm_num) a).ne'
  have hcop2 : (2:ℕ).Coprime m := (Nat.coprime_two_left).mpr hm_odd
  have hcop : (2 ^ a).Coprime m := hcop2.pow_left a
  have heq : sigmaStar (2 ^ a) * sigmaStar m = 2 * (2 ^ a * m) :=
    (by rw [← sigmaStar_mul_of_coprime h2apos hm0 hcop]; exact hperfect)
  rw [sigmaStar_prime_pow (by norm_num) ha] at heq
  have hrhs : 2 * (2 ^ a * m) = 2 ^ (a + 1) * m := (by rw [pow_succ']; ring)
  rw [hrhs] at heq
  have hseedk : ∃ k, (2:ℕ) ^ a = 2 * k := ⟨2 ^ (a - 1), by rw [← pow_succ']; congr 1; omega⟩
  obtain ⟨k, hk⟩ := hseedk
  have hodd_seed : ¬ (2 ∣ 2 ^ a + 1) := (by rw [Nat.dvd_iff_mod_eq_zero]; omega)
  have hmmod := Nat.odd_iff.mp hm_odd
  have hnot2m : ¬ (2 ∣ m) := (by rw [Nat.dvd_iff_mod_eq_zero]; omega)
  have hsm0 : sigmaStar m ≠ 0 :=
    (by
      intro h0
      rw [h0, mul_zero] at heq
      have hlt : (0:ℕ) < 2 ^ (a + 1) * m := (by positivity)
      omega)
  have hne1 : (2:ℕ) ^ a + 1 ≠ 0 := (by positivity)
  have hne2 : (2:ℕ) ^ (a + 1) ≠ 0 := (by positivity)
  have hfactL : ((2 ^ a + 1) * sigmaStar m).factorization 2
      = (2 ^ a + 1).factorization 2 + (sigmaStar m).factorization 2 :=
    (by
      have hcongrL := congrArg (fun f => f 2) (Nat.factorization_mul hne1 hsm0)
      simpa using hcongrL)
  have hfactR : ((2:ℕ) ^ (a + 1) * m).factorization 2
      = ((2:ℕ) ^ (a + 1)).factorization 2 + m.factorization 2 :=
    (by
      have hcongrR := congrArg (fun f => f 2) (Nat.factorization_mul hne2 hm0)
      simpa using hcongrR)
  have hcongr : (2 ^ a + 1).factorization 2 + (sigmaStar m).factorization 2
      = ((2:ℕ) ^ (a + 1)).factorization 2 + m.factorization 2 :=
    (by rw [← hfactL, ← hfactR, heq])
  have h1 : (2 ^ a + 1).factorization 2 = 0 :=
    Nat.factorization_eq_zero_of_not_dvd hodd_seed
  have h2 : m.factorization 2 = 0 :=
    Nat.factorization_eq_zero_of_not_dvd hnot2m
  have h3 : ((2:ℕ) ^ (a + 1)).factorization 2 = a + 1 :=
    Nat.factorization_pow_self (by norm_num)
  rw [h1, h3, h2] at hcongr
  have hval : (sigmaStar m).factorization 2 = a + 1 := (by omega)
  have hdvdfinal := (Nat.Prime.pow_dvd_iff_le_factorization (p := 2) (by norm_num) hsm0).mp
    (two_pow_card_primeFactors_dvd_sigmaStar m hm_odd)
  omega

end OmegaOddLeTwoAdicAddOne

end MathCorpus.Frontier.Erdos
