import Mathlib
/-!
# Choosing all n items is always 1 way

Packet: `elementary.combinatorics.choose_self.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The number of ways to choose all n items from n is always 1 — the full set is the unique n-element choice.
Kernel-verified through the tracked proof-search loop (episode 0f2f545b).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem choose_self' (n : ℕ) : Nat.choose n n = 1 := by
  exact Nat.choose_self n

end MathCorpus.Elementary.Combinatorics
