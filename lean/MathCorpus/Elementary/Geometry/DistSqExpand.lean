import Mathlib
/-!
# Squared distance expands via the binomial formula

Packet: `elementary.geometry.dist_sq_expand.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Squared distance expands via the binomial formula.
Kernel-verified through the tracked proof-search loop (episode 4c7778eb).
-/

namespace MathCorpus.Elementary.Geometry

theorem dist_sq_expand : ∀ (x y : ℝ), (x - y) ^ 2 = x ^ 2 - 2 * x * y + y ^ 2 := by
  intro x y; ring

end MathCorpus.Elementary.Geometry
