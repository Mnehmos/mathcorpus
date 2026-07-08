import Mathlib
/-!
# Product of positive terms over a range is positive

Packet: `elementary.induction.prod_range_pos.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every n and every f : ℕ → ℕ with f i > 0 on all i < n, the product of f over
range n is positive. A general reusable lemma via induction, complementing this
domain's existing prod_range_succ/prod_range_monotone.
Kernel-verified through the tracked proof-search loop (episode bdbcc4ba).
-/

namespace MathCorpus.Elementary.Induction

theorem prod_range_pos :
    ∀ (n : ℕ) (f : ℕ → ℕ), (∀ i ∈ Finset.range n, 0 < f i) → 0 < ∏ i ∈ Finset.range n, f i := by
  intro n
  induction n with
  | zero => intro f hf; norm_num
  | succ k ih =>
    intro f hf
    rw [Finset.prod_range_succ]
    exact Nat.mul_pos (ih f (fun i hi => hf i (Finset.mem_range.mpr (Nat.lt_succ_of_lt (Finset.mem_range.mp hi))))) (hf k (Finset.self_mem_range_succ k))

end MathCorpus.Elementary.Induction
