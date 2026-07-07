import Mathlib
/-!
# Union is associative

Packet: `elementary.combinatorics.union_assoc.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The union of finite sets is associative.
Kernel-verified through the tracked proof-search loop (episode 0319b31c).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem union_assoc' (s t u : Finset ℕ) : s ∪ t ∪ u = s ∪ (t ∪ u) := by
  exact Finset.union_assoc s t u

end MathCorpus.Elementary.Combinatorics
