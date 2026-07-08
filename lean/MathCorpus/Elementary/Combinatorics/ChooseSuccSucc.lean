import Mathlib
/-!
# Pascal's rule for binomial coefficients

Packet: `elementary.combinatorics.choose_succ_succ.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

Pascal's rule: the number of ways to choose k+1 items from n+1 equals the number of ways that include a fixed item (choose k from the remaining n) plus the number of ways that exclude it (choose k+1 from the remaining n).
Kernel-verified through the tracked proof-search loop (episode 53ff8716).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem choose_succ_succ'' (n k : ℕ) : Nat.choose (n + 1) (k + 1) = Nat.choose n k + Nat.choose n (k + 1) := by
  exact Nat.choose_succ_succ' n k

end MathCorpus.Elementary.Combinatorics
