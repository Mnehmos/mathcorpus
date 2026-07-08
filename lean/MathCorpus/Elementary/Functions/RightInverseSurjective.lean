import Mathlib
/-!
# A right inverse implies surjectivity

Packet: `elementary.functions.right_inverse_surjective.v1`
Level:  L1_proof_basics · Domain: functions · Trust rung 1 (Lean kernel).

If g is a right inverse of f (f(g(x)) = x for all x), then f is
surjective -- the companion to `left_inverse_injective`, completing this
domain's "inverse" focus pair.
Kernel-verified through the tracked proof-search loop (episode 6f12df1e).
-/

namespace MathCorpus.Elementary.Functions

theorem right_inverse_surjective (α β : Type) (f : α → β) (g : β → α)
    (h : Function.RightInverse g f) : Function.Surjective f := by
  intro b
  exact ⟨g b, h b⟩

end MathCorpus.Elementary.Functions
