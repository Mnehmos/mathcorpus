import Mathlib
/-!
# Any nonzero natural number is positive

Packet: `elementary.number_theory.nat_pos_of_ne_zero.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

Any nonzero natural number is positive.
Kernel-verified through the tracked proof-search loop (episode 641c48b1).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem nat_pos_of_ne_zero : ∀ (n : ℕ), n ≠ 0 → 0 < n := by
  intro n h; exact Nat.pos_of_ne_zero h

end MathCorpus.Elementary.NumberTheory
