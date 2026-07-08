import Mathlib
/-!
# Composition of strictly monotone functions is strictly monotone

Packet: `elementary.functions.strictmono_comp.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

If f : alpha -> beta and g : beta -> gamma are both strictly monotone, then g ∘ f is
strictly monotone. Pairs with the already-authored monotone_comp and
strictmono_injective, completing the monotone-family lemma cluster.
Kernel-verified through the tracked proof-search loop (episode 21aeb6a1).
-/

namespace MathCorpus.Elementary.Functions

theorem strictmono_comp :
    ∀ {α β γ : Type} [Preorder α] [Preorder β] [Preorder γ] (f : α → β) (g : β → γ),
      StrictMono f → StrictMono g → StrictMono (g ∘ f) := by
  intro α β γ _ _ _ f g hf hg a b hab
  exact hg (hf hab)

end MathCorpus.Elementary.Functions
