import Mathlib

/-!
# Continuous sum of continuous functions

Packet: `undergrad.real_analysis.continuous_add.v1`
Level:  L3_undergrad · Domain: real_analysis · Trust rung 1 (Lean kernel).

The sum of two continuous real-valued functions is continuous.
-/

namespace MathCorpus.Undergrad.RealAnalysis

theorem continuous_add' {α : Type*} [TopologicalSpace α] {f g : α → ℝ}
    (hf : Continuous f) (hg : Continuous g) : Continuous (fun x => f x + g x) := by
  exact hf.add hg

end MathCorpus.Undergrad.RealAnalysis
