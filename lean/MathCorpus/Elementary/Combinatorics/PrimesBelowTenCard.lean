import Mathlib
/-!
# There are 4 primes less than 10

Packet: `elementary.combinatorics.primes_below_ten_card.v1`
Level:  L1_proof_basics · Domain: combinatorics · Trust rung 1 (Lean kernel).

`((Finset.range 10).filter Nat.Prime).card = 4` (the primes 2, 3, 5, 7).
Kernel-verified through the tracked proof-search loop (episode
d7f066f6): `decide` closes this finite computation directly -- bare
`simp` cannot, since its default simp set does not unfold `Finset.filter`
over a concrete range combined with the `Nat.Prime` decidability instance
all the way to a numeral (see the paired negative example
`negative.combinatorics.filter_prime_simp.no_progress.v1`).
-/

namespace MathCorpus.Elementary.Combinatorics

theorem primes_below_ten_card : ((Finset.range 10).filter (fun n => Nat.Prime n)).card = 4 := by
  decide

end MathCorpus.Elementary.Combinatorics
