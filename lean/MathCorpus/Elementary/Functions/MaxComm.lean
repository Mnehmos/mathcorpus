import Mathlib
/-!
# Maximum is commutative

Packet: `elementary.functions.max_comm.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

The maximum of two reals does not depend on their order.
Kernel-verified through the tracked proof-search loop (episode 289f2251).
-/

namespace MathCorpus.Elementary.Functions

theorem max_comm' (a b : ℝ) : max a b = max b a := by
  exact max_comm a b

end MathCorpus.Elementary.Functions
