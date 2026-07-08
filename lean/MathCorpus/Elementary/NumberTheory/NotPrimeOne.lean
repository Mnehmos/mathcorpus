import Mathlib
/-!
# 1 is not prime

Packet: `elementary.number_theory.not_prime_one.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

1 is not a prime number -- pairs with `prime_two`.
Kernel-verified through the tracked proof-search loop (episode ec66cf9d).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem not_prime_one : ¬ Nat.Prime 1 := by
  norm_num

end MathCorpus.Elementary.NumberTheory
