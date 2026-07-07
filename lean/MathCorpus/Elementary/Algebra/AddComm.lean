import Mathlib
/-!
# Addition is commutative

Packet: `elementary.algebra.add_comm.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Integer addition is commutative.
Kernel-verified through the tracked proof-search loop (episode 41a3a963).
-/

namespace MathCorpus.Elementary.Algebra

theorem add_comm' (a b : ℤ) : a + b = b + a := by
  exact add_comm a b

end MathCorpus.Elementary.Algebra
