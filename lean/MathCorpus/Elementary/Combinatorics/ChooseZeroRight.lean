import Mathlib
/-!
# Choosing 0 items is always 1 way

Packet: `elementary.combinatorics.choose_zero_right.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The number of ways to choose 0 items from n is always 1 — the empty subset is the unique 0-element choice.
Kernel-verified through the tracked proof-search loop (episode dbba5471).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem choose_zero_right' (n : ℕ) : Nat.choose n 0 = 1 := by
  exact Nat.choose_zero_right n

end MathCorpus.Elementary.Combinatorics
