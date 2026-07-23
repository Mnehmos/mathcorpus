import Mathlib

/-!
# Finsets of size at most 2 containing a non-empty set satisfy the half-density bound

Packet: `elementary.logic.finset_card_two_nonempty_density.v1`
Level:  L1_proof_basics · Domain: logic · Trust rung 1 (Lean kernel).

For any non-empty family F of finsets of size at most 2 containing at least one non-empty set,
there exists an element x belonging to at least half of the sets in F.
-/

namespace MathCorpus.Elementary.Logic

theorem finset_card_two_nonempty_density' : ∀ {α : Type*} [DecidableEq α] (F : Finset (Finset α)),
    F.Nonempty → F.card ≤ 2 → (∃ s ∈ F, s.Nonempty) → ∃ x, 2 * (F.filter (fun s => x ∈ s)).card ≥ F.card := by
  intro α inst F hne hcard hnonempty
  obtain ⟨s, hs, hsn⟩ := hnonempty
  obtain ⟨x, hx⟩ := hsn
  use x
  have h1 : s ∈ F.filter (fun t => x ∈ t) := Finset.mem_filter.mpr ⟨hs, hx⟩
  have h2 : 1 ≤ (F.filter (fun t => x ∈ t)).card := Finset.card_pos.mpr ⟨s, h1⟩
  omega

end MathCorpus.Elementary.Logic
