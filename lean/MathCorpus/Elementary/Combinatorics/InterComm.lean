import Mathlib
/-!
# Intersection is commutative

Packet: `elementary.combinatorics.inter_comm.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

The intersection of two finite sets does not depend on order.
Kernel-verified through the tracked proof-search loop (episode 64fd1982).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem inter_comm' (s t : Finset ℕ) : s ∩ t = t ∩ s := by
  exact Finset.inter_comm s t

end MathCorpus.Elementary.Combinatorics
