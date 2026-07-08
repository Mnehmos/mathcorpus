import Mathlib

/-!
# A strictly monotone function is injective

Packet: `elementary.functions.strictmono_injective.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For α linearly ordered and β preordered, a strictly monotone f : α → β is
injective. Proved directly via trichotomy rather than citing Mathlib's
`StrictMono.injective`, for instructional value. Connects this domain's
"monotone" and "injective" focus topics directly.
Kernel-verified through the tracked proof-search loop (episode aef62b6e).
-/

namespace MathCorpus.Elementary.Functions

theorem strictMono_injective {α β : Type*} [LinearOrder α] [Preorder β]
    (f : α → β) : StrictMono f → Function.Injective f := by
  intro hf a b hab
  rcases lt_trichotomy a b with h | h | h
  · exact absurd hab (ne_of_lt (hf h))
  · exact h
  · exact absurd hab.symm (ne_of_lt (hf h))

end MathCorpus.Elementary.Functions
