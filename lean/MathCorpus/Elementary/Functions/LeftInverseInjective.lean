import Mathlib
/-!
# A left inverse implies injectivity

Packet: `elementary.functions.left_inverse_injective.v1`
Level:  L1_proof_basics · Domain: functions · Trust rung 1 (Lean kernel).

If g is a left inverse of f (g(f(x)) = x for all x), then f is
injective -- the fundamental connection between this domain's "inverse"
and "injective" focus items.
Kernel-verified through the tracked proof-search loop (episode 05445672).
-/

namespace MathCorpus.Elementary.Functions

theorem left_inverse_injective (α β : Type) (f : α → β) (g : β → α)
    (h : Function.LeftInverse g f) : Function.Injective f := by
  intro a b hab
  have hg : g (f a) = g (f b) := congrArg g hab
  rwa [h a, h b] at hg

end MathCorpus.Elementary.Functions
