import Mathlib

/-!
Erdős #1052 companion infrastructure: σ* (unitary-divisor-sum) special cases.

Transported from the sibling repo's `Erdos1052_sigmaStar_and_bounds.lean`
(mnehmos.llm-driven-proof-search.environment/ErdosProblems/erdos-1052/proof/),
independently re-verified through this repo's own tracked proof-search loop.
Bounded to the prime/prime-power special cases only -- NOT the general
multiplicativity theorem `sigmaStar_mul_of_coprime` (deferred: its proof needs a
5-branch `Finset.sum_nbij'` with nested bullet case splits, a bigger bullet-free
rewrite than this cycle's scope) and NOT `omega_odd_le_two_adic_add_one` (which
depends on that multiplicativity theorem). NOT Erdős #1052 itself (genuinely
OPEN: are there finitely many unitary perfect numbers?), and NOT the full
Subbarao-Warren `even_of_isUnitaryPerfect` headline theorem either.
-/

namespace MathCorpus.Frontier.Erdos

-- Module-local scope: sibling Erdos-1052 snapshots re-declare shared helpers
-- (uDiv, sigmaStar, ...); this inner namespace keeps the root import collision-free.
namespace SigmaStarPrimePowAndPrime

def uDiv : ℕ → Finset ℕ := fun n => n.divisors.filter (fun d => Nat.Coprime d (n / d))

theorem mem_uDiv : ∀ {n d : ℕ}, n ≠ 0 → (d ∈ uDiv n ↔ d ∣ n ∧ Nat.Coprime d (n / d)) := by
  intro n d hn
  simp [uDiv, Nat.mem_divisors, hn]

def sigmaStar : ℕ → ℕ := fun n => ∑ d ∈ uDiv n, d

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
      have : 1 < p ^ e := Nat.one_lt_pow (by omega) hp.one_lt
      omega)
  rw [Finset.sum_insert (Finset.mem_singleton.not.mpr h1e), Finset.sum_singleton]
  omega

theorem sigmaStar_prime : ∀ {p : ℕ}, p.Prime → sigmaStar p = p + 1 := by
  intro p hp
  have h := sigmaStar_prime_pow hp (le_refl 1)
  simpa using h

end SigmaStarPrimePowAndPrime

end MathCorpus.Frontier.Erdos
