import Mathlib
/-!
# Union with itself is idempotent

Packet: `elementary.combinatorics.union_self.v1`
Level:  L0_elementary · Domain: combinatorics · Trust rung 1 (Lean kernel).

The union of a finite set with itself is the set.
Kernel-verified through the tracked proof-search loop (episode ace03cb8).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem union_self' (s : Finset ℕ) : s ∪ s = s := by
  exact Finset.union_self s

end MathCorpus.Elementary.Combinatorics
