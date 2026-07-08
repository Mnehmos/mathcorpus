import Mathlib

/-!
# Erdős #1052 companion infrastructure: p-free unitary divisors

Packet: `frontier.erdos.erdos_1052_filter_ordcompl.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Continues the bounded infrastructure toward the Subbarao–Warren (1966)
result that unitary perfect numbers are even (Erdős #1052's
`research solved` variant), started in
`frontier.erdos.erdos_1052_proper_eq_erase.v1` and
`frontier.erdos.erdos_1052_not_dvd_div_ordproj.v1`.

Redeclares `uDiv`/`mem_uDiv` (SubmitModule submissions are self-contained
per episode) and proves the root fact: the `p`-free unitary divisors of
`n` are exactly the unitary divisors of the `p`-free part `ordCompl[p] n`.

**Still not the headline result.** `sum_uDiv_factor` (a `Finset.sum_bij'`
argument with deeply nested bullets) and `sum_uDiv_even` (a
`Finset.sum_involution` argument) remain deferred as the genuinely hard
remaining pieces.

The original's `constructor` + two `.`-bullet `Iff` case splits were
rewritten as a single `Iff.intro (fun ... => (by ...)) (fun ... => (by
...))` term, with each direction's multi-step body wrapped in its own
parenthesized `by`-block (per the flattened-sequence lesson: any
`have h := by tac1; tac2` followed by more sibling tactics must be
parenthesized as `have h := (by tac1; tac2)`, or the trailing tactics get
silently swallowed into the inner block) — the same template that worked
for `proper_eq_erase`.
Kernel-verified through the tracked proof-search loop (episode 32ac25bb).
-/

namespace MathCorpus.Frontier.Erdos

/-- All unitary divisors of `n`, including `1` and `n`. -/
def uDiv (n : ℕ) : Finset ℕ := n.divisors.filter (fun d => Nat.Coprime d (n / d))

theorem mem_uDiv {n d : ℕ} (hn : n ≠ 0) :
    d ∈ uDiv n ↔ d ∣ n ∧ Nat.Coprime d (n / d) := by
  simp [uDiv, Nat.mem_divisors, hn]

/-- The `p`-free unitary divisors of `n` are exactly the unitary divisors of
the `p`-free part `ordCompl[p] n`. -/
theorem filter_not_dvd_eq_uDiv_ordCompl {n p : ℕ} (hn : n ≠ 0) (hp : p.Prime) :
    (uDiv n).filter (fun d => ¬ p ∣ d) = uDiv (ordCompl[p] n) := by
  have hm0 : (ordCompl[p] n) ≠ 0 := (Nat.ordCompl_pos p hn).ne'
  have hPm : ordProj[p] n * ordCompl[p] n = n := Nat.ordProj_mul_ordCompl_eq_self n p
  ext e
  rw [Finset.mem_filter, mem_uDiv hn, mem_uDiv hm0]
  refine Iff.intro (fun ⟨⟨hedvd, hcop⟩, hpe⟩ => ?_) (fun ⟨hem, hcop⟩ => ?_)
  · have hcpe : Nat.Coprime e (ordProj[p] n) :=
      Nat.Coprime.pow_right _ ((hp.coprime_iff_not_dvd.mpr hpe).symm)
    have hem : e ∣ ordCompl[p] n := by
      refine hcpe.dvd_of_dvd_mul_left ?_
      rw [hPm]
      exact hedvd
    refine ⟨hem, ?_⟩
    have hne : n / e = ordProj[p] n * (ordCompl[p] n / e) := by
      rw [← Nat.mul_div_assoc _ hem, hPm]
    have hdd : ordCompl[p] n / e ∣ n / e := by
      rw [hne]
      exact dvd_mul_left _ _
    exact Nat.Coprime.coprime_dvd_right hdd hcop
  · have hpe : ¬ p ∣ e := fun hpe =>
      Nat.not_dvd_ordCompl hp hn (hpe.trans hem)
    have hedvd : e ∣ n := hem.trans (Nat.ordCompl_dvd n p)
    refine ⟨⟨hedvd, ?_⟩, hpe⟩
    have hne : n / e = ordProj[p] n * (ordCompl[p] n / e) := by
      rw [← Nat.mul_div_assoc _ hem, hPm]
    rw [hne]
    exact Nat.Coprime.mul_right (Nat.Coprime.pow_right _ ((hp.coprime_iff_not_dvd.mpr hpe).symm)) hcop

end MathCorpus.Frontier.Erdos
