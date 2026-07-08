import Mathlib
/-!
# Binomial coefficient symmetry

Packet: `elementary.combinatorics.choose_symm.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

Choosing k items from n is the same as choosing which n-k items to leave out: the binomial coefficient is symmetric, choose n k = choose n (n-k), for k <= n.
Kernel-verified through the tracked proof-search loop (episode 2478c40d).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem choose_symm' (n k : ℕ) (hk : k ≤ n) : Nat.choose n k = Nat.choose n (n - k) := by
  exact (Nat.choose_symm hk).symm

end MathCorpus.Elementary.Combinatorics
