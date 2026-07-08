import Mathlib
/-!
# Erdős #349 sublemma: every natural is a sum of distinct powers of 2

Packet: `frontier.erdos.erdos_349_exists_finset_sum_two_pow.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Sublemma supporting Erdős #349 (isGoodPair characterization): every
natural number `k` is a sum of distinct powers of 2 over some finite
index set `E` (binary representation existence). This is infrastructure
supporting #349, not a resolution of the problem itself.

Statement matches `exists_finset_sum_two_pow` from
`google-deepmind/formal-conjectures FormalConjectures/ErdosProblems/349.lean`
(hash `2328323a2b3bbeba5fa2318fbc84fd47675231f738edc38166e21687ced920ed`,
confirmed byte-identical: this packet's own `root_statement_hash` matches).
Kernel-verified through the tracked proof-search loop (episode a6801189),
re-proving the result already Lean-verified in the sibling repo at
`F:\Github\mnehmos.llm-driven-proof-search.environment\ErdosProblems\erdos-349\proof\Erdos349_exists_finset_sum_two_pow.lean`
(its own tracked episode `844e5846-fc4b-4651-b1dd-9e0735a643ce`).
-/

namespace MathCorpus.Frontier.Erdos

theorem erdos_349_exists_finset_sum_two_pow (k : ℕ) :
    ∃ E : Finset ℕ, k = ∑ i ∈ E, 2 ^ i :=
  ⟨k.bitIndices.toFinset, (Finset.sum_toFinset_bitIndices_two_pow k).symm⟩

end MathCorpus.Frontier.Erdos
