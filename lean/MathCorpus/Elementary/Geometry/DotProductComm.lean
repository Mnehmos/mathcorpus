import Mathlib
/-!
# Dot product is commutative

Packet: `elementary.geometry.dot_product_comm.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The planar dot product (a,b)·(c,d) is commutative.
Kernel-verified through the tracked proof-search loop (episode d280307b).
-/

namespace MathCorpus.Elementary.Geometry

theorem dot_product_comm (a b c d : ℝ) : a * c + b * d = c * a + d * b := by
  ring

end MathCorpus.Elementary.Geometry
