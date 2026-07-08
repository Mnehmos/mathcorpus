import Mathlib
/-!
# Partial products of a >=1-valued sequence are monotone

Packet: `elementary.induction.prod_range_monotone.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every function f : ℕ -> ℕ with f i >= 1 for all i, and natural numbers n, k: the partial product over range n is at most the partial product over range (n+k) -- finite partial products of a >=1-valued sequence are monotone in the upper bound. Mirrors sum_range_monotone.v1, but products need the >=1 hypothesis (unlike sums, which only need >=0, automatic in ℕ).
Kernel-verified through the tracked proof-search loop (episode 5918401a).
-/

namespace MathCorpus.Elementary.Induction

theorem prod_range_monotone (f : ℕ → ℕ) (hf : ∀ i, 1 ≤ f i) (n k : ℕ) : (∏ i ∈ Finset.range n, f i) ≤ ∏ i ∈ Finset.range (n + k), f i := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [show n + (k + 1) = (n + k) + 1 from rfl, Finset.prod_range_succ]
    exact le_trans ih (le_mul_of_one_le_right (Nat.zero_le _) (hf (n + k)))

end MathCorpus.Elementary.Induction
