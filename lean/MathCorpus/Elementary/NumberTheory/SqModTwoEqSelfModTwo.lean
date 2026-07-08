import Mathlib
/-!
# Squares preserve parity

Packet: `elementary.number_theory.sq_mod_two_eq_self_mod_two.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

For every natural n, n^2 and n have the same remainder mod 2 (the same
parity). A bare `omega` attempt fails first (see the paired negative
example negative.number_theory.sq_parity.omega_nonlinear_failure.v1):
omega cannot relate the opaque atom n^2 back to n. Case-splitting on the
parity of n first (Nat.even_or_odd) reduces the goal to a linear form
omega can close.
Kernel-verified through the tracked proof-search loop (episode d656e3da).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem sq_mod_two_eq_self_mod_two (n : ℕ) : n ^ 2 % 2 = n % 2 := by
  rcases Nat.even_or_odd n with ⟨k, rfl⟩ | ⟨k, rfl⟩ <;> ring_nf <;> omega

end MathCorpus.Elementary.NumberTheory
