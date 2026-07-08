import Mathlib
/-!
# Powers of 2 are strictly monotone in the exponent

Packet: `elementary.induction.two_pow_strictmono.v1`
Level:  L1_proof_basics · Domain: induction · Trust rung 1 (Lean kernel).

n < m implies 2^n < 2^m. Fills the domain's weakest-covered focus item,
"monotonicity" (previously only `sum_range_monotone`/`prod_range_monotone`
existed), while also touching "powers" -- both explicit `LOOP.md` focus
items.
Kernel-verified through the tracked proof-search loop (episode 9416dbd4).
-/

namespace MathCorpus.Elementary.Induction

theorem two_pow_strictMono (n m : ℕ) (h : n < m) : 2 ^ n < 2 ^ m := by
  have hmono : StrictMono (fun k : ℕ => (2:ℕ) ^ k) := by
    apply strictMono_nat_of_lt_succ
    intro k
    have hpos : 0 < 2 ^ k := pow_pos (by norm_num) k
    rw [pow_succ]
    omega
  exact hmono h

end MathCorpus.Elementary.Induction
