import Mathlib
open scoped BigOperators

/-!
# Sum of the first n cubes

Packet: `elementary.induction.sum_cubes.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For every natural n, four times the sum of the first n cubes equals (n(n+1))^2 (Nicomachus's theorem).
Kernel-verified through the tracked proof-search loop (episode e1d3de46).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_cubes (n : ℕ) : (∑ i ∈ Finset.range (n + 1), i ^ 3) * 4 = (n * (n + 1)) ^ 2 := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, add_mul, ih]
    ring

end MathCorpus.Elementary.Induction
