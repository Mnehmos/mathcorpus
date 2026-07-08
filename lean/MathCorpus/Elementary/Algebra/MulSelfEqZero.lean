import Mathlib
/-!
# A product of a real with itself is zero iff the real is zero

Packet: `elementary.algebra.mul_self_eq_zero.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

A product of a real with itself is zero iff the real is zero.
Kernel-verified through the tracked proof-search loop (episode 152b51e8).
-/

namespace MathCorpus.Elementary.Algebra

theorem mul_self_eq_zero : ∀ (a : ℝ), a * a = 0 ↔ a = 0 := by
  intro a; exact _root_.mul_self_eq_zero

end MathCorpus.Elementary.Algebra
