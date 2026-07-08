import Mathlib
/-!
# Zero to a positive power is zero

Packet: `elementary.algebra.zero_pow_succ.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Zero to a positive power is zero.
Kernel-verified through the tracked proof-search loop (episode 4eb4e72f).
-/

namespace MathCorpus.Elementary.Algebra

theorem zero_pow_succ : ∀ (n : ℕ), (0 : ℤ) ^ (n + 1) = 0 := by
  intro n; simp

end MathCorpus.Elementary.Algebra
