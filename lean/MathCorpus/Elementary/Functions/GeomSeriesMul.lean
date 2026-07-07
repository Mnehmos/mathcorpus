import Mathlib
open scoped BigOperators

/-!
# Finite geometric series times (r-1)

Packet: `elementary.functions.geom_series_mul.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For a real number r and natural n, the finite geometric sum 1 + r + ... + r^(n-1) times (r - 1) equals r^n - 1.
Kernel-verified through the tracked proof-search loop (episode 94a27d2a).
-/

namespace MathCorpus.Elementary.Functions

theorem geom_series_mul (r : ℝ) (n : ℕ) : (∑ i ∈ Finset.range n, r ^ i) * (r - 1) = r ^ n - 1 := by
  exact geom_sum_mul r n

end MathCorpus.Elementary.Functions
