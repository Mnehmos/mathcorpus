import Mathlib
/-!
# OEIS A358684: a 2-adic valuation bound on Fermat number factors

Packet: `frontier.formal_conjectures.oeis_a358684_conjecture_0.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Source: https://oeis.org/A358684, Conjecture 3.4 in Lorenzo Sauras-Altuzarra,
"Some properties of the factors of Fermat numbers", Art Discrete Appl.
Math. (2022). Letting `F n = 2^(2^n)+1` be the n-th Fermat number and
`P n = minFac (F n)` its smallest prime factor, this bounds the 2-adic
valuation of `P n - 1` by `2^n - a n`, where `a n = 2^n - log2 (P n)`.

Upstream Lean statement (sibling repo
mnehmos.llm-driven-proof-search.environment/formal-conjectures,
FormalConjectures/OEIS/358684.lean::oeis_358684_conjecture_0) introduces
`a` as a separate file-local `def`; this packet inlines `a n` directly as
its closed form (`2^n - Nat.log2 (Nat.minFac (Nat.fermatNumber n))`) since
the root statement registered with the proof-search environment must be
self-contained (no dependency on a not-yet-defined local `def`) --
mathematically identical, not a simplification.

Three repairs were needed versus a verbatim transport of the upstream
proof term (see this packet's `notes` field for the full account):
unqualified `sub_le` (needs `Nat.sub_le` here, since `SubmitModule`/`Solve`
gives no `open Nat` preamble), `(by norm_num)` cannot discharge
`Nat.fermatNumber n ≠ 1` for symbolic `n` (needs the general lemma
`Nat.fermatNumber_ne_one`), and an `intro n` since the root statement is
a bare `∀`-quantified Prop rather than a theorem with `n` as a named
argument.

Kernel-verified through the tracked proof-search loop (episode
8bf75cf7-35f9-4c10-8015-3a9411a6df52).
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem oeis_a358684_conjecture_0 :
    ∀ n : ℕ, padicValNat 2 (Nat.minFac (Nat.fermatNumber n) - 1) ≤
      2 ^ n - (2 ^ n - Nat.log2 (Nat.minFac (Nat.fermatNumber n))) := by
  intro n
  rw [Nat.sub_sub_self]
  · rw [Nat.log2_eq_log_two]
    apply Nat.le_log_of_pow_le (by decide)
    refine le_trans ?_ <| Nat.sub_le _ 1
    apply Nat.ordProj_le 2
    exact Nat.sub_ne_zero_of_lt (Nat.minFac_prime (Nat.fermatNumber_ne_one n)).one_lt
  · rw [Nat.log2_eq_log_two]
    have : (2 ^ 2 ^ n) + 1 < 2 ^ ((2 ^ n) + 1) := by
      simp [pow_add, mul_two]
    refine Nat.le_of_lt_succ <| (2).log_lt_of_lt_pow ?_ ?_
    · exact Nat.minFac_pos _ |>.ne'
    · exact (Nat.minFac_le (by bound)).trans_lt this

end MathCorpus.Frontier.FormalConjectures
