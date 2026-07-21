import Mathlib

/-!
# Union-closed families of size at most 2 satisfy the union-closed sets condition

Packet: `frontier.union_closed_three_sets.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

For any non-empty family F of finsets of size at most 2 containing at least one non-empty set,
there exists an element x belonging to at least half of the sets in F.
-/

namespace MathCorpus.Frontier.Combinatorics

theorem union_closed_three_sets' : ∀ {α : Type*} [DecidableEq α] (F : Finset (Finset α)),
    F.Nonempty → F.card ≤ 2 → (∃ s ∈ F, s.Nonempty) → ∃ x, 2 * (F.filter (fun s => x ∈ s)).card ≥ F.card := by
  intro α inst F hne hcard hnonempty
  obtain ⟨s, hs, hsn⟩ := hnonempty
  obtain ⟨x, hx⟩ := hsn
  use x
  have h1 : s ∈ F.filter (fun t => x ∈ t) := Finset.mem_filter.mpr ⟨hs, hx⟩
  have h2 : 1 ≤ (F.filter (fun t => x ∈ t)).card := Finset.card_pos.mpr ⟨s, h1⟩
  omega

end MathCorpus.Frontier.Combinatorics
