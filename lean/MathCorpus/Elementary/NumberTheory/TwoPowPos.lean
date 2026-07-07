import Mathlib
/-!
# Powers of two are positive

Packet: `elementary.number_theory.two_pow_pos.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

For every natural n, 2^n > 0.
Kernel-verified through the tracked proof-search loop (episode c1e97609).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem two_pow_pos' (n : ℕ) : 0 < 2 ^ n := by
  positivity

end MathCorpus.Elementary.NumberTheory
