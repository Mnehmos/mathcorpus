import Mathlib

/-!
# Continuous product of continuous functions

Packet: `undergrad.real_analysis.continuous_mul.v1`
Level:  L3_undergrad · Domain: real_analysis · Trust rung 1 (Lean kernel).

The product of two continuous real-valued functions is continuous.
-/

namespace MathCorpus.Undergrad.RealAnalysis

theorem continuous_mul' {α : Type*} [TopologicalSpace α] {f g : α → ℝ}
    (hf : Continuous f) (hg : Continuous g) : Continuous (fun x => f x * g x) := by
  exact hf.mul hg

end MathCorpus.Undergrad.RealAnalysis
