import Mathlib
/-!
# Union-closed sets conjecture: the |universe| = 2 special case

Packet: `frontier.formal_conjectures.union_closed_univ_card_two.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Source: https://en.wikipedia.org/wiki/Union-closed_sets_conjecture --
the union-closed sets conjecture (Frankl's conjecture) states that for
any finite family A of finite sets closed under union, with A != {emptyset},
some element belongs to at least half the sets of A. This packet proves
the special case where the ambient universe is `Fin 2` (i.e. every set in
A is a subset of a 2-element type), by brute-force decision procedure
over the finitely many possible families A.

ANTI-OVERCLAIM: the general conjecture (arbitrary finite ambient type)
remains open; this packet only covers the |universe| = 2 case. The
upstream `IsUnionClosed A` predicate (`∀ᵉ (X ∈ A) (Y ∈ A), X ∪ Y ∈ A`) is
inlined directly since it is a transparent `abbrev`, not a load-bearing
custom type.

Kernel-verified through the tracked proof-search loop (episode
62b2eaf2-50d7-47ca-96ce-4a180fcf2cb4).
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem union_closed_univ_card_two :
    ∀ (A : Finset (Finset (Fin 2))), A ≠ {∅} → (∀ᵉ (X ∈ A) (Y ∈ A), X ∪ Y ∈ A) →
      ∃ i, (1 / 2 : ℚ) * (A.card : ℚ) ≤ ((A.filter (fun x => i ∈ x)).card : ℚ) := by
  intro A hA hUC
  decide +revert +kernel

end MathCorpus.Frontier.FormalConjectures
