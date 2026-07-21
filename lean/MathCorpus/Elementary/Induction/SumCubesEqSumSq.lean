import Mathlib
/-!
# Nicomachus's theorem (sum of cubes equals square of the sum)

Packet: `elementary.induction.sum_cubes_eq_sum_sq.v1`
Level:  L1_proof_basics · Domain: induction · Trust rung 1 (Lean kernel).

The sum of the first n+1 cubes equals the square of the sum of the
first n+1 naturals -- Nicomachus's theorem in its classic, elegant,
division-free form. The domain already has `gauss_sum` and `sum_cubes`
in their separate "*2"/"*4" closed forms; this packet states the direct
relationship between them.
Kernel-verified through the tracked proof-search loop (episode 7b9d236e).
-/

namespace MathCorpus.Elementary.Induction

theorem sum_cubes_eq_sum_sq (n : ℕ) :
    (∑ i ∈ Finset.range (n + 1), i ^ 3) = (∑ i ∈ Finset.range (n + 1), i) ^ 2 := by
  have hgauss : ∀ m : ℕ, (∑ i ∈ Finset.range (m + 1), i) * 2 = m * (m + 1) := by
    intro m
    induction m with
    | zero => simp
    | succ k ih => rw [Finset.sum_range_succ, add_mul, ih]; ring
  have hcubes : ∀ m : ℕ, (∑ i ∈ Finset.range (m + 1), i ^ 3) * 4 = (m * (m + 1)) ^ 2 := by
    intro m
    induction m with
    | zero => simp
    | succ k ih => rw [Finset.sum_range_succ, add_mul, ih]; ring
  have key : (∑ i ∈ Finset.range (n + 1), i ^ 3) * 4 = (∑ i ∈ Finset.range (n + 1), i) ^ 2 * 4 := by
    rw [hcubes n, ← hgauss n]; ring
  omega

end MathCorpus.Elementary.Induction
