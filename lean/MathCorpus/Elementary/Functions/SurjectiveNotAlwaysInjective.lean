import Mathlib
/-!
# Surjective does not imply injective on an infinite domain

Packet: `elementary.functions.surjective_not_always_injective.v1`
Level:  L1_proof_basics · Domain: functions · Trust rung 1 (Lean kernel).

The finite pigeonhole fact (surjective implies injective for functions
between finite sets of equal cardinality) does not generalize to ℕ:
`n ↦ n - 1` (Nat truncated subtraction) is surjective (`f (m+1) = m` for
every `m`) but not injective (`f 0 = f 1 = 0`). Kernel-verified through
the tracked proof-search loop (episode 0b3fa2fb). Paired negative
example: `negative.functions.surjective_implies_injective.finite_pigeonhole_misapplied.v1`
(the natural first attempt to prove the unconditional claim directly).
-/

namespace MathCorpus.Elementary.Functions

theorem surjective_not_always_injective :
    ¬ (∀ f : ℕ → ℕ, Function.Surjective f → Function.Injective f) := by
  intro h
  have hsurj : Function.Surjective (fun n : ℕ => n - 1) :=
    (by intro m; exact ⟨m + 1, by simp⟩)
  have hinj := h _ hsurj
  have h01 : (0 : ℕ) = 1 := hinj (show (0 : ℕ) - 1 = 1 - 1 from by decide)
  exact absurd h01 (by decide)

end MathCorpus.Elementary.Functions
