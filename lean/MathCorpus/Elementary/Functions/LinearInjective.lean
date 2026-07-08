import Mathlib

/-!
# Affine functions with nonzero slope are injective

Packet: `elementary.functions.linear_injective.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For real a, b with a ≠ 0, the affine function f(x) = a * x + b is
injective. The general parametrized form, as opposed to
`linear_injective_concrete_instance` (a fixed concrete instance).
Kernel-verified through the tracked proof-search loop (episode ea9a41a4).
-/

namespace MathCorpus.Elementary.Functions

theorem linear_injective (a b : ℝ) (ha : a ≠ 0) :
    Function.Injective (fun x : ℝ => a * x + b) := by
  intro x y hxy
  have h : a * x = a * y := by linarith
  exact mul_left_cancel₀ ha h

end MathCorpus.Elementary.Functions
