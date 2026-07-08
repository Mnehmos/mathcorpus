import Mathlib
/-!
# Exponent successor law

Packet: `elementary.algebra.pow_succ.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

x^(n+1) = x^n * x for a real base and natural exponent -- small but
reusable in induction successor-case proofs.
Kernel-verified through the tracked proof-search loop (episode 869150c9).
-/

namespace MathCorpus.Elementary.Algebra

theorem pow_succ' (x : ℝ) (n : ℕ) : x ^ (n + 1) = x ^ n * x := by
  ring

end MathCorpus.Elementary.Algebra
