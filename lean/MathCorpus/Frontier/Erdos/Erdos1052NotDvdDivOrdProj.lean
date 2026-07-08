import Mathlib

/-!
# Erdős #1052 companion infrastructure: removing the full p-part is p-free

Packet: `frontier.erdos.erdos_1052_not_dvd_div_ordproj.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Continues the bounded infrastructure toward the Subbarao–Warren (1966)
result that unitary perfect numbers are even (Erdős #1052's
`research solved` variant), started in
`frontier.erdos.erdos_1052_proper_eq_erase.v1`.

Redeclares `uDiv`/`mem_uDiv` (SubmitModule submissions are self-contained
per episode, so cross-episode declarations are not directly reusable),
adds `ordProj_dvd_of_mem_uDiv` (in a unitary divisor `d` of `n` divisible
by `p`, the FULL `p`-part of `n` divides `d`), and proves the root fact:
if the full `p`-part of `n` divides `d`, then removing it leaves a
`p`-free quotient.

**Still not the headline result.** `sum_uDiv_factor` (a `Finset.sum_bij'`
argument) and `sum_uDiv_even` (a `Finset.sum_involution` argument) remain
deferred — both use deeply nested `.`-bullet case splits needing
substantial bullet-free restructuring, unlike the lemmas transported here
(and in the prior packet), which needed no bullet rewrites at all.
Kernel-verified through the tracked proof-search loop (episode 2d9c2f64).
-/

namespace MathCorpus.Frontier.Erdos

/-- All unitary divisors of `n`, including `1` and `n`. -/
def uDiv (n : ℕ) : Finset ℕ := n.divisors.filter (fun d => Nat.Coprime d (n / d))

theorem mem_uDiv {n d : ℕ} (hn : n ≠ 0) :
    d ∈ uDiv n ↔ d ∣ n ∧ Nat.Coprime d (n / d) := by
  simp [uDiv, Nat.mem_divisors, hn]

/-- In a unitary divisor divisible by `p`, the FULL `p`-part of `n` divides. -/
theorem ordProj_dvd_of_mem_uDiv {n p d : ℕ} (hn : n ≠ 0) (hp : p.Prime)
    (hd : d ∈ uDiv n) (hpd : p ∣ d) : ordProj[p] n ∣ d := by
  rw [mem_uDiv hn] at hd
  obtain ⟨hdvd, hcop⟩ := hd
  have hpnd : ¬ p ∣ (n / d) := fun hpnd =>
    hp.one_lt.ne' (Nat.dvd_one.mp (hcop ▸ Nat.dvd_gcd hpd hpnd))
  have h0 : (n / d).factorization p = 0 := Nat.factorization_eq_zero_of_not_dvd hpnd
  have happ : (n / d).factorization p = n.factorization p - d.factorization p := by
    rw [Nat.factorization_div hdvd]
    rfl
  have hle : n.factorization p ≤ d.factorization p :=
    Nat.sub_eq_zero_iff_le.mp (happ ▸ h0)
  calc ordProj[p] n = p ^ n.factorization p := rfl
    _ ∣ p ^ d.factorization p := pow_dvd_pow p hle
    _ ∣ d := Nat.ordProj_dvd d p

/-- Removing the full `p`-part of `n` from a divisor leaves it `p`-free. -/
theorem not_dvd_div_ordProj {n p d : ℕ} (hn : n ≠ 0) (hp : p.Prime)
    (hdvd : d ∣ n) (hPd : ordProj[p] n ∣ d) : ¬ p ∣ d / ordProj[p] n := by
  intro hpq
  have hd_eq : ordProj[p] n * (d / ordProj[p] n) = d := Nat.mul_div_cancel' hPd
  have hstep : p ^ (n.factorization p + 1) ∣ d := by
    rw [pow_succ, ← hd_eq]
    exact mul_dvd_mul_left _ hpq
  have hcontra := (Nat.Prime.pow_dvd_iff_le_factorization hp hn).mp (hstep.trans hdvd)
  omega

end MathCorpus.Frontier.Erdos
