import Mathlib
/-!
# Intersection with itself is idempotent

Packet: `elementary.combinatorics.inter_self.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The intersection of a finite set with itself is the set.
Kernel-verified through the tracked proof-search loop (episode 2c341acb).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem inter_self' (s : Finset ℕ) : s ∩ s = s := by
  exact Finset.inter_self s

end MathCorpus.Elementary.Combinatorics
