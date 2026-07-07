import Mathlib
/-!
# Union is commutative

Packet: `elementary.combinatorics.union_comm.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The union of two finite sets does not depend on order.
Kernel-verified through the tracked proof-search loop (episode 4491104f).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem union_comm' (s t : Finset ℕ) : s ∪ t = t ∪ s := by
  exact Finset.union_comm s t

end MathCorpus.Elementary.Combinatorics
