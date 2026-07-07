import Mathlib
/-!
# Minimum is commutative

Packet: `elementary.functions.min_comm.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The minimum of two reals does not depend on their order.
Kernel-verified through the tracked proof-search loop (episode 0c4aa90d).
-/

namespace MathCorpus.Elementary.Functions

theorem min_comm' (a b : ℝ) : min a b = min b a := by
  exact min_comm a b

end MathCorpus.Elementary.Functions
