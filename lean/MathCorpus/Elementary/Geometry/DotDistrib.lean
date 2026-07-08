import Mathlib
/-!
# The dot product distributes over vector addition

Packet: `elementary.geometry.dot_distrib.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

The dot product distributes over vector addition.
Kernel-verified through the tracked proof-search loop (episode 4dac75d5).
-/

namespace MathCorpus.Elementary.Geometry

theorem dot_distrib : ∀ (a b c d e f : ℝ), a * (c + e) + b * (d + f) = (a * c + b * d) + (a * e + b * f) := by
  intro a b c d e f; ring

end MathCorpus.Elementary.Geometry
