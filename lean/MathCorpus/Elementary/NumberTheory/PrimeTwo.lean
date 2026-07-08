import Mathlib
/-!
# 2 is prime

Packet: `elementary.number_theory.prime_two.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

2 is a prime number -- the domain's first primality fact.
Kernel-verified through the tracked proof-search loop (episode 86b4db53).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem prime_two : Nat.Prime 2 := by
  norm_num

end MathCorpus.Elementary.NumberTheory
