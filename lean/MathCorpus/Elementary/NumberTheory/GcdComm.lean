import Mathlib
/-!
# gcd is commutative

Packet: `elementary.number_theory.gcd_comm.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The greatest common divisor of two naturals does not depend on their order.
Kernel-verified through the tracked proof-search loop (episode 9fb09e15).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem gcd_comm' (a b : ℕ) : Nat.gcd a b = Nat.gcd b a := by
  exact Nat.gcd_comm a b

end MathCorpus.Elementary.NumberTheory
