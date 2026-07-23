import Mathlib

/-!
# Erdős #1052 companion infrastructure: unitary-divisor bridge lemma

Packet: `frontier.erdos.erdos_1052_proper_eq_erase.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Bounded infrastructure toward the Subbarao–Warren (1966) result that
unitary perfect numbers are even (Erdős #1052's `research solved`
variant). Defines `uDiv n`, the set of unitary divisors of `n` (divisors
`d` with `gcd(d, n/d) = 1`), and proves the corpus's
`properUnitaryDivisors` convention (`{d ∈ [1,n) : d ∣ n ∧ coprime(d, n/d)}`)
equals `uDiv n` with `n` itself removed.

**This is NOT the headline result.** The full `even_of_isUnitaryPerfect`
theorem additionally needs `ordProj_dvd_of_mem_uDiv`,
`not_dvd_div_ordProj`, `filter_not_dvd_eq_uDiv_ordCompl`,
`sum_uDiv_factor` (a `Finset.sum_bij'` argument), and `sum_uDiv_even` (a
`Finset.sum_involution` argument) — deferred to a future cycle since those
bijection/involution proofs need substantial bullet-free restructuring
(SubmitModule helper items are always flattened and cannot preserve
`.`-bullet case splits; see `packets/frontier/erdos/BLOCKERS.md` and
`COMPANION_RESULTS.md`).

Transported from the sibling repo's already kernel_verified
`ErdosProblems/erdos-1052/proof/Erdos1052_even_of_isUnitaryPerfect.lean`
(`mem_uDiv`, `self_mem_uDiv`, `proper_eq_erase`), re-verified independently
in this repo's own pinned toolchain. The two `·`-bullet `Iff` case-splits
in the original `proper_eq_erase` were rewritten as a single
`Iff.intro (fun ⟨...⟩ => ...) (fun ⟨...⟩ => ?_)` term, continuing linearly
with ordinary tactics for the one remaining goal — no bullets needed since
`refine` here only ever leaves one pending goal at a time.
Kernel-verified through the tracked proof-search loop (episode 59a627f1).
-/

namespace MathCorpus.Frontier.Erdos

-- Module-local scope: sibling Erdos-1052 snapshots re-declare shared helpers
-- (uDiv, sigmaStar, ...); this inner namespace keeps the root import collision-free.
namespace ProperEqErase

/-- All unitary divisors of `n`, including `1` and `n`. -/
def uDiv (n : ℕ) : Finset ℕ := n.divisors.filter (fun d => Nat.Coprime d (n / d))

theorem mem_uDiv {n d : ℕ} (hn : n ≠ 0) :
    d ∈ uDiv n ↔ d ∣ n ∧ Nat.Coprime d (n / d) := by
  simp [uDiv, Nat.mem_divisors, hn]

theorem self_mem_uDiv {n : ℕ} (hn : n ≠ 0) : n ∈ uDiv n := by
  rw [mem_uDiv hn]
  refine ⟨dvd_rfl, ?_⟩
  rw [Nat.div_self (Nat.pos_of_ne_zero hn)]
  exact Nat.coprime_one_right n

/-- The corpus's `properUnitaryDivisors n` equals `uDiv n` minus `n` itself. -/
theorem proper_eq_erase {n : ℕ} (hn : n ≠ 0) :
    ({d ∈ Finset.Ico 1 n | d ∣ n ∧ d.Coprime (n / d)} : Finset ℕ) = (uDiv n).erase n := by
  ext d
  rw [Finset.mem_filter, Finset.mem_Ico, Finset.mem_erase, mem_uDiv hn]
  refine Iff.intro (fun ⟨⟨_, hlt⟩, hdvd, hcop⟩ => ⟨hlt.ne, hdvd, hcop⟩) (fun ⟨hne, hdvd, hcop⟩ => ?_)
  have hpos : 0 < d := Nat.pos_of_dvd_of_pos hdvd (Nat.pos_of_ne_zero hn)
  have hle : d ≤ n := Nat.le_of_dvd (Nat.pos_of_ne_zero hn) hdvd
  exact ⟨⟨hpos, lt_of_le_of_ne hle hne⟩, hdvd, hcop⟩

end ProperEqErase

end MathCorpus.Frontier.Erdos
