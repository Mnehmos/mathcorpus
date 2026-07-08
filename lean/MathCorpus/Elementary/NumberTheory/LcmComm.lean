import Mathlib

/-!
# lcm is commutative

Packet: `elementary.number_theory.lcm_comm.v1`
Level:  L0_elementary · Domain: number_theory · Trust rung 1 (Lean kernel).

The least common multiple of two naturals does not depend on their order.
Kernel-verified through the tracked proof-search loop (episode 38f8f47e).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem lcm_comm' (a b : ℕ) : Nat.lcm a b = Nat.lcm b a := Nat.lcm_comm a b

end MathCorpus.Elementary.NumberTheory
