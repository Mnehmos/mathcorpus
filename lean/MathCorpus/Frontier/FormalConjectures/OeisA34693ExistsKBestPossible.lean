import Mathlib
/-!
# OEIS A34693: the bound 1 + n^0.74 is not always valid

Packet: `frontier.formal_conjectures.oeis_a34693_exists_k_best_possible.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Source: https://oeis.org/A34693 -- a(n) is the smallest k such that n*k+1 is
prime. Upstream Lean statement (sibling repo
mnehmos.llm-driven-proof-search.environment/formal-conjectures,
FormalConjectures/OEIS/34693.lean::exists_k_best_possible) shows the
candidate upper bound `1 + n^0.74` (expressed there via `Real.nthRoot 100 n
^ 74`) is NOT always valid, witnessed at n=19.

This packet restates the goal using `Real.rpow` directly
(`(n:ℝ) ^ ((74:ℝ)/100)`) instead of the upstream `Real.nthRoot 100 n ^ 74`
-- mathematically identical for n ≥ 0, since nthRoot 100 n ^ 74 = n^(74/100)
-- because `Real.nthRoot` does not resolve under this environment's pinned
Mathlib revision (it appears to have been replaced/renamed to a
Nat-valued `nthRoot`; see `packets/frontier/formal_conjectures/BLOCKERS.md`
for the general lesson). This is an environment/API-availability
adaptation, not a mathematical simplification or overclaim.

Kernel-verified through the tracked proof-search loop (episode
406c3860-6fcf-40b3-82a5-4a3a1726a89f).
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem oeis_a34693_exists_k_best_possible :
    ∃ n > (0 : ℕ), ∀ (k : ℕ), (k:ℝ) < 1 + (n:ℝ) ^ ((74:ℝ)/100) → ¬(n * k + 1).Prime := by
  refine ⟨19, by norm_num, ?_⟩
  have hb : (19:ℝ) ^ ((74:ℝ)/100) ≤ 9 := by
    have key : ((19:ℝ) ^ ((74:ℝ)/100)) ^ (100:ℕ) ≤ (9:ℝ) ^ (100:ℕ) := by
      rw [← Real.rpow_natCast ((19:ℝ) ^ ((74:ℝ)/100)) 100, ← Real.rpow_mul (by norm_num : (0:ℝ) ≤ 19)]
      norm_num
    exact (pow_le_pow_iff_left₀ (by positivity) (by norm_num) (by norm_num)).mp key
  intro k hk
  have hk10 : (k:ℝ) < 10 := by linarith
  have hk10' : k < 10 := by exact_mod_cast hk10
  interval_cases k <;> norm_num

end MathCorpus.Frontier.FormalConjectures
