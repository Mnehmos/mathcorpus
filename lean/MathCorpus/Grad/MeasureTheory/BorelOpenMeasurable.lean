import Mathlib

/-!
# Open sets in a topological space are Borel measurable

Packet: `measure_theory.borel_space_is_open_measurable.v1`
Level:  L5_grad · Domain: measure_theory · Trust rung 1 (Lean kernel).

In any space equipped with a Borel measurable structure, open sets are measurable.
-/

namespace MathCorpus.Grad.MeasureTheory

theorem borel_space_is_open_measurable' : ∀ {α : Type*} [TopologicalSpace α] [MeasurableSpace α] [BorelSpace α] {s : Set α}, IsOpen s → MeasurableSet s := by
  intro α instT instM instB s hs
  exact hs.measurableSet

end MathCorpus.Grad.MeasureTheory
